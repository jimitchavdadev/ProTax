// lib/widgets/common/styled_text_field.dart
import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType keyboardType;

  const StyledTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFF60748A)),
        filled: true,
        fillColor: const Color(0xFFF0F2F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
