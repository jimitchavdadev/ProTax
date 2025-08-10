// backend/lib/src/calculators/business_tax_calculator.dart
import 'dart:math';
import '../models/tax_data.dart';
import '../models/tax_inputs.dart';
import '../models/tax_result.dart';

TaxResult calculateBusinessTax(BusinessInput input) {
  double tax = 0;
  double surcharge = 0;
  double taxRate;

  if (input.businessType == "Partnership & LLP") {
    // FIX #1: Convert tax rate from int to double
    taxRate = (businessTaxData.firstWhere((e) =>
            e['Category'] == 'Partnership & LLP' &&
            e['Sub-Category'] == 'Base Tax Rate')['Rate_or_Limit'] as num)
        .toDouble();
    tax = input.revenue * (taxRate / 100);

    final surchargeInfo = businessTaxData
        .where((e) =>
            e['Category'] == 'Partnership & LLP' &&
            e['Sub-Category'] == 'Surcharge Rate')
        .first;
    final threshold = double.parse(
        surchargeInfo['Income_Threshold_INR'].replaceAll('>', '').trim());

    if (input.revenue > threshold) {
      // FIX #2: Convert surcharge rate from int to double
      final surchargeRate = (surchargeInfo['Rate_or_Limit'] as num).toDouble();
      surcharge = tax * (surchargeRate / 100);
    }
  } else {
    // Corporate Tax
    // FIX #3: Convert tax rate from int to double
    taxRate = (businessTaxData.firstWhere((e) =>
            e['Category'] == 'Corporate Tax' &&
            e['Sub-Category'] == input.businessType)['Rate_or_Limit'] as num)
        .toDouble();
    tax = input.revenue * (taxRate / 100);

    final surchargeCategory =
        input.businessType.contains('Foreign') ? 'Foreign Co' : 'Domestic Co';
    final applicableSurcharges = businessTaxData.where((e) {
      if (e['Category'] != 'Corporate Surcharge' ||
          e['Sub-Category'] != surchargeCategory) return false;
      final thresholdStr = e['Income_Threshold_INR'].replaceAll('>', '').trim();
      final threshold = double.tryParse(thresholdStr);
      return threshold != null && input.revenue > threshold;
    }).toList();

    if (applicableSurcharges.isNotEmpty) {
      final highestBracket = applicableSurcharges.reduce((curr, next) {
        final currThreshold = double.parse(
            curr['Income_Threshold_INR'].replaceAll('>', '').trim());
        final nextThreshold = double.parse(
            next['Income_Threshold_INR'].replaceAll('>', '').trim());
        return currThreshold > nextThreshold ? curr : next;
      });
      // FIX #4: Convert surcharge rate from int to double
      final surchargeRate = (highestBracket['Rate_or_Limit'] as num).toDouble();
      surcharge = tax * (surchargeRate / 100);
    }
  }

  // Calculate Cess
  final taxPlusSurcharge = tax + surcharge;
  // FIX #5: Convert cess rate from int to double
  final cessRate = (businessTaxData
          .firstWhere((e) => e['Category'] == 'Cess')['Rate_or_Limit'] as num)
      .toDouble();
  final cess = taxPlusSurcharge * (cessRate / 100);
  final totalTax = taxPlusSurcharge + cess;

  return TaxResult(
    taxableIncome: input.revenue,
    baseTax: tax,
    surcharge: surcharge,
    cess: cess,
    totalTax: totalTax,
  );
}
