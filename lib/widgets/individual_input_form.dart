// lib/widgets/individual_input_form.dart
import 'package:flutter/material.dart';
import '../models/deduction_model.dart';
import 'common/styled_text_field.dart';
import 'deductions_section.dart';

class IndividualInputForm extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController incomeController;
  final bool claimDeductions;
  final ValueChanged<bool> onDeductionToggle;
  final List<Deduction> deductions;

  const IndividualInputForm({
    super.key,
    required this.ageController,
    required this.incomeController,
    required this.claimDeductions,
    required this.onDeductionToggle,
    required this.deductions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        StyledTextField(controller: ageController, placeholder: "Age"),
        const SizedBox(height: 12),
        StyledTextField(
          controller: incomeController,
          placeholder: "Annual Income (₹)",
        ),
        const SizedBox(height: 12),
        DeductionsSection(
          isVisible: claimDeductions,
          onToggle: onDeductionToggle,
          deductions: deductions,
        ),
      ],
    );
  }
}
