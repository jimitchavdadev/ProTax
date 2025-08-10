// lib/models/deduction_model.dart
import 'package:flutter/material.dart';

class Deduction {
  String name;
  double limit;
  TextEditingController controller;

  Deduction({required this.name, this.limit = double.infinity})
    : controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }
}
