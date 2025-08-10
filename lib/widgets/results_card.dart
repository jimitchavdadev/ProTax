// lib/widgets/results_card.dart
import 'package:flutter/material.dart';
import 'package:protax/backend/backend.dart'; // Import the backend library

class ResultsCard extends StatelessWidget {
  final TaxResult results;
  const ResultsCard({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111418),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Taxable Income: ₹ ${results.taxableIncome.toStringAsFixed(2)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildResultRow("Base Tax", results.baseTax),
          _buildResultRow("Surcharge", results.surcharge),
          if (results.rebate > 0)
            _buildResultRow("Rebate", results.rebate, isDeduction: true),
          _buildResultRow("Health & Edu Cess", results.cess),
          const Divider(color: Colors.white30, height: 24),
          Text(
            "Total Tax Liability: ₹ ${results.totalTax.toStringAsFixed(2)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, double value,
      {bool isDeduction = false}) {
    if (value == 0 && !isDeduction) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
          Text(
            "${isDeduction ? '-' : ''}₹ ${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: isDeduction ? Colors.greenAccent : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
