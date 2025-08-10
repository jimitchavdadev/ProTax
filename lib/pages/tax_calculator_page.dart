// lib/pages/tax_calculator_page.dart
import 'package:flutter/material.dart';

// Import the single library entry point
import 'package:protax/backend/backend.dart'; // <-- CORRECTED IMPORT

import '../models/deduction_model.dart';
import '../widgets/business_input_form.dart';
import '../widgets/common/calculate_button.dart';
import '../widgets/individual_input_form.dart';
import '../widgets/results_card.dart';
import '../widgets/user_type_segmented_control.dart';

class TaxCalculatorPage extends StatefulWidget {
  const TaxCalculatorPage({super.key});

  @override
  _TaxCalculatorPageState createState() => _TaxCalculatorPageState();
}

class _TaxCalculatorPageState extends State<TaxCalculatorPage> {
  // State variables
  int _selectedUserType = 0;
  bool _claimIndividualDeductions = false;
  bool _claimBusinessDeductions = false;
  TaxResult? _taxResult; // Holds the result from the backend

  // Controllers
  final _ageController = TextEditingController();
  final _incomeController = TextEditingController();
  final _revenueController = TextEditingController();
  String? _selectedBusinessType; // Holds the dropdown value

  // Data from backend
  List<String> _businessTypes = [];

  // Deduction lists for UI
  final List<Deduction> _individualDeductions = [
    Deduction(name: "Section 80C", limit: 150000),
    Deduction(name: "Health Insurance (80D)"),
  ];
  final List<Deduction> _businessDeductions = [
    Deduction(name: "Depreciation"),
    Deduction(name: "Salaries"),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch business types from the backend when the app starts
    _loadBusinessTypes();
  }

  void _loadBusinessTypes() {
    setState(() {
      _businessTypes = getBusinessTypes();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    _ageController.dispose();
    _incomeController.dispose();
    _revenueController.dispose();
    for (var d in _individualDeductions) {
      d.dispose();
    }
    for (var d in _businessDeductions) {
      d.dispose();
    }
    super.dispose();
  }

  /// Gathers UI data, calls the backend, and updates the state with the result.
  void _performTaxCalculation() {
    dynamic input; // Can be IndividualInput or BusinessInput

    // --- This part is the same ---
    if (_selectedUserType == 0) {
      // Individual
      final double totalDeductions = _claimIndividualDeductions
          ? _individualDeductions.fold(
              0.0,
              (sum, item) =>
                  sum + (double.tryParse(item.controller.text) ?? 0.0))
          : 0.0;

      input = IndividualInput(
        age: int.tryParse(_ageController.text) ?? 0,
        income: double.tryParse(_incomeController.text) ?? 0.0,
        totalDeductions: totalDeductions,
      );
    } else {
      // Business
      if (_selectedBusinessType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a business type.')),
        );
        return;
      }
      input = BusinessInput(
        businessType: _selectedBusinessType!,
        revenue: double.tryParse(_revenueController.text) ?? 0.0,
      );
    }

    // --- This part is NEW ---
    // Use a try-catch block to find hidden errors
    try {
      final result = calculateTax(input: input);
      setState(() {
        _taxResult = result;
      });
    } catch (e, stackTrace) {
      // If an error occurs, it will be caught here
      setState(() {
        _taxResult = null; // Ensure the card is hidden
      });

      // Show the error on the screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error during calculation. Check debug console.')),
      );

      // Print the detailed error to your debug console
      print('--- CALCULATION FAILED ---');
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      print('--------------------------');
    }
  }

  void _onUserTypeChanged(int index) {
    setState(() {
      _selectedUserType = index;
      _taxResult = null; // Clear results when switching
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tax Calculator",
            style: TextStyle(
                color: Color(0xFF111418), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              UserTypeSegmentedControl(
                selectedIndex: _selectedUserType,
                onSelectionChanged: _onUserTypeChanged,
              ),
              if (_selectedUserType == 0)
                IndividualInputForm(
                  ageController: _ageController,
                  incomeController: _incomeController,
                  claimDeductions: _claimIndividualDeductions,
                  onDeductionToggle: (value) =>
                      setState(() => _claimIndividualDeductions = value),
                  deductions: _individualDeductions,
                )
              else
                BusinessInputForm(
                  selectedBusinessType: _selectedBusinessType,
                  onBusinessTypeChanged: (value) =>
                      setState(() => _selectedBusinessType = value),
                  businessTypes: _businessTypes,
                  revenueController: _revenueController,
                  claimDeductions: _claimBusinessDeductions,
                  onDeductionToggle: (value) =>
                      setState(() => _claimBusinessDeductions = value),
                  deductions: _businessDeductions,
                ),
              const SizedBox(height: 20),
              CalculateButton(onPressed: _performTaxCalculation),
              const SizedBox(height: 20),
              if (_taxResult != null) ResultsCard(results: _taxResult!),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
