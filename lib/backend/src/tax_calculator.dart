// backend/lib/tax_calculator.dart
library;

import 'calculators/business_tax_calculator.dart';
import 'calculators/individual_tax_calculator.dart';
import 'models/tax_inputs.dart';
import 'models/tax_result.dart';

// Public API function for the entire backend
TaxResult calculateTax({required dynamic input}) {
  if (input is IndividualInput) {
    return calculateIndividualTax(input);
  } else if (input is BusinessInput) {
    return calculateBusinessTax(input);
  } else {
    throw ArgumentError(
      'Invalid input type. Must be IndividualInput or BusinessInput.',
    );
  }
}

// You can also expose the business types for your UI dropdown
List<String> getBusinessTypes() {
  final types = [
    "Domestic Co. (Turnover <= 400 Cr)",
    "Domestic Co. (Turnover > 400 Cr)",
    "Domestic Co. (Opted for Sec 115BAA)",
    "Domestic Co. (Opted for Sec 115BAB)",
    "Foreign Co.",
    "Partnership & LLP",
  ];
  return types;
}
