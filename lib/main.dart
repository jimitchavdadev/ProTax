import 'package:flutter/material.dart';
import 'pages/tax_calculator_page.dart'; // Import the new page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tax Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Public Sans', // Make sure to add the font to pubspec.yaml
      ),
      home: const TaxCalculatorPage(), // Set the page as home
      debugShowCheckedModeBanner: false,
    );
  }
}
