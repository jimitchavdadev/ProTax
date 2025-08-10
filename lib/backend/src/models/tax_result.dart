// backend/lib/src/models/tax_result.dart

class TaxResult {
  final double taxableIncome;
  final double baseTax;
  final double surcharge;
  final double cess;
  final double rebate;
  final double totalTax;
  final Map<String, double> details;

  TaxResult({
    this.taxableIncome = 0.0,
    this.baseTax = 0.0,
    this.surcharge = 0.0,
    this.cess = 0.0,
    this.rebate = 0.0,
    this.totalTax = 0.0,
    this.details = const {},
  });

  @override
  String toString() {
    return """
--- Tax Calculation Result ---
Taxable Income: ${taxableIncome.toStringAsFixed(2)}
Base Tax:       ${baseTax.toStringAsFixed(2)}
Surcharge:      ${surcharge.toStringAsFixed(2)}
Rebate:         ${rebate.toStringAsFixed(2)}
Cess:           ${cess.toStringAsFixed(2)}
--------------------------------
Total Tax:      ${totalTax.toStringAsFixed(2)}
""";
  }
}
