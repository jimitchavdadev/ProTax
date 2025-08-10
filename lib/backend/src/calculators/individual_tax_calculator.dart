// backend/lib/src/calculators/individual_tax_calculator.dart
import 'dart:math';
import '../models/tax_data.dart';
import '../models/tax_inputs.dart';
import '../models/tax_result.dart';

TaxResult calculateIndividualTax(IndividualInput input) {
  // Use a fixed standard deduction for simplicity as per the original script
  // THE FIX IS ON THIS LINE: converting the 'int' from data to a 'double'
  final double standardDeduction = (individualTaxData.firstWhere(
          (e) => e['Sub-Category'] == 'Standard Deduction')['Limit_INR'] as num)
      .toDouble();

  final double taxableIncome =
      max(0, input.income - (input.totalDeductions + standardDeduction));
  double tax = 0;

  // Define slab category based on age (can be expanded)
  final slabCategory = 'Individual < 60';
  final taxSlabs = individualTaxData
      .where((e) =>
          e['Category'] == 'Tax Slab' && e['Sub-Category'] == slabCategory)
      .toList();

  // Sort slabs by parsing the lower bound of the income range
  taxSlabs.sort((a, b) {
    final aLow = int.tryParse(a['Income_Slab_INR'].split(' - ')[0]) ?? 0;
    final bLow = int.tryParse(b['Income_Slab_INR'].split(' - ')[0]) ?? 0;
    return aLow.compareTo(bLow);
  });

  double remainingIncome = taxableIncome;

  for (final slab in taxSlabs) {
    final slabStr = slab['Income_Slab_INR'] as String;
    final rate = slab['Rate_Percent'] as num;

    if (slabStr.contains('>')) {
      final low = double.parse(slabStr.replaceAll(RegExp(r'[>,]'), '').trim());
      if (remainingIncome > low) {
        tax += (remainingIncome - low) * (rate / 100);
      }
    } else if (slabStr.contains('-')) {
      final parts = slabStr.split(' - ');
      final low = double.parse(parts[0].trim());
      final high = double.parse(parts[1].trim());
      if (remainingIncome > low) {
        final taxableInSlab = min(remainingIncome, high) - low;
        tax += taxableInSlab * (rate / 100);
      }
    }
  }

  // Calculate Surcharge
  double surcharge = 0;
  final applicableSurcharges = individualTaxData.where((e) {
    if (e['Category'] != 'Surcharge') return false;
    final thresholdStr =
        e['Income_Slab_INR'].replaceAll(RegExp(r'[>,]'), '').trim();
    final threshold = double.tryParse(thresholdStr);
    return threshold != null && taxableIncome > threshold;
  }).toList();

  if (applicableSurcharges.isNotEmpty) {
    // Find the highest applicable bracket
    final highestBracket = applicableSurcharges.reduce((curr, next) {
      final currThreshold = double.parse(
          curr['Income_Slab_INR'].replaceAll(RegExp(r'[>,]'), '').trim());
      final nextThreshold = double.parse(
          next['Income_Slab_INR'].replaceAll(RegExp(r'[>,]'), '').trim());
      return currThreshold > nextThreshold ? curr : next;
    });
    final surchargeRate = highestBracket['Rate_Percent'] as num;
    surcharge = tax * (surchargeRate / 100);
  }

  // Calculate Cess
  final taxPlusSurcharge = tax + surcharge;
  final cessRate = individualTaxData.firstWhere(
          (e) => e['Sub-Category'] == 'Health & Education Cess')['Rate_Percent']
      as num;
  final cess = taxPlusSurcharge * (cessRate / 100);

  // Calculate Rebate
  double rebate = 0;
  final rebateInfo = individualTaxData
      .firstWhere((e) => e['Sub-Category'] == 'Tax Rebate (Sec 87A)');
  final rebateLimit = double.parse(
      rebateInfo['Income_Slab_INR'].replaceAll(RegExp(r'[<=,]'), '').trim());

  if (taxableIncome <= rebateLimit) {
    final rebateAmount = rebateInfo['Limit_INR'] as num;
    rebate = min(taxPlusSurcharge + cess, rebateAmount.toDouble());
  }

  final totalTax = max(0, taxPlusSurcharge + cess - rebate);

  return TaxResult(
    taxableIncome: taxableIncome,
    baseTax: tax,
    surcharge: surcharge,
    cess: cess,
    rebate: rebate,
    totalTax: totalTax.toDouble(),
  );
}
