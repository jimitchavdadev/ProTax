// lib/widgets/common/calculate_button.dart
import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CalculateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D78F2),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: const Text("Calculate Tax"),
    );
  }
}
