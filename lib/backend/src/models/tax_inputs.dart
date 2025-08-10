// backend/lib/src/models/tax_inputs.dart

class IndividualInput {
  final int age;
  final double income;
  final double totalDeductions;

  IndividualInput({
    required this.age,
    required this.income,
    this.totalDeductions = 0.0,
  });
}

class BusinessInput {
  final String businessType;
  final double revenue;

  BusinessInput({required this.businessType, required this.revenue});
}
