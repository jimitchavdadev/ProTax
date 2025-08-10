// lib/widgets/business_input_form.dart
import 'package:flutter/material.dart';
import '../models/deduction_model.dart';
import 'common/styled_text_field.dart';
import 'deductions_section.dart';

class BusinessInputForm extends StatelessWidget {
  final String? selectedBusinessType;
  final ValueChanged<String?> onBusinessTypeChanged;
  final List<String> businessTypes; // List from backend
  final TextEditingController revenueController;
  final bool claimDeductions;
  final ValueChanged<bool> onDeductionToggle;
  final List<Deduction> deductions;

  const BusinessInputForm({
    super.key,
    required this.selectedBusinessType,
    required this.onBusinessTypeChanged,
    required this.businessTypes,
    required this.revenueController,
    required this.claimDeductions,
    required this.onDeductionToggle,
    required this.deductions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Dropdown for Business Type
        DropdownButtonFormField<String>(
          value: selectedBusinessType,
          items: businessTypes
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: onBusinessTypeChanged,
          decoration: InputDecoration(
            hintText: "Select Business Type",
            hintStyle: const TextStyle(color: Color(0xFF60748A)),
            filled: true,
            fillColor: const Color(0xFFF0F2F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        StyledTextField(
          controller: revenueController,
          placeholder: "Total Revenue (₹)",
        ),
        const SizedBox(height: 12),
        // Note: The current backend does not process business deductions.
        // This UI is for demonstration and future expansion.
        DeductionsSection(
          isVisible: claimDeductions,
          onToggle: onDeductionToggle,
          deductions: deductions,
        ),
      ],
    );
  }
}
