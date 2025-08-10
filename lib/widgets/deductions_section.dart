// lib/widgets/deductions_section.dart
import 'package:flutter/material.dart';
import '../models/deduction_model.dart';
import 'common/styled_text_field.dart';

class DeductionsSection extends StatelessWidget {
  final bool isVisible;
  final ValueChanged<bool> onToggle;
  final List<Deduction> deductions;

  const DeductionsSection({
    super.key,
    required this.isVisible,
    required this.onToggle,
    required this.deductions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDeductionsToggle(),
        if (isVisible) _buildDeductionsList(),
      ],
    );
  }

  Widget _buildDeductionsToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Claim Deductions", style: TextStyle(fontSize: 16)),
          Switch(
            value: isVisible,
            onChanged: onToggle,
            activeColor: const Color(0xFF0D78F2),
          ),
        ],
      ),
    );
  }

  Widget _buildDeductionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: deductions.map((deduction) {
        return Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: StyledTextField(
            controller: deduction.controller,
            placeholder:
                "${deduction.name} (Max: ₹${deduction.limit == double.infinity ? 'N/A' : deduction.limit.toStringAsFixed(0)})",
            keyboardType: TextInputType.number,
          ),
        );
      }).toList(),
    );
  }
}
