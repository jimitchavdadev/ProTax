// backend/lib/src/models/tax_data.dart

// Data sourced from individuals.csv
final List<Map<String, dynamic>> individualTaxData = [
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '0 - 300000',
    'Rate_Percent': 0,
    'Limit_INR': null,
  },
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '300001 - 600000',
    'Rate_Percent': 5,
    'Limit_INR': null,
  },
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '600001 - 900000',
    'Rate_Percent': 10,
    'Limit_INR': null,
  },
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '900001 - 1200000',
    'Rate_Percent': 15,
    'Limit_INR': null,
  },
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '1200001 - 1500000',
    'Rate_Percent': 20,
    'Limit_INR': null,
  },
  {
    'Category': 'Tax Slab',
    'Sub-Category': 'Individual < 60',
    'Income_Slab_INR': '> 1500000',
    'Rate_Percent': 30,
    'Limit_INR': null,
  },
  // Add other slabs for Senior and Super Senior Citizens here if needed
  {
    'Category': 'Surcharge',
    'Sub-Category': 'On Tax',
    'Income_Slab_INR': '> 5000000',
    'Rate_Percent': 10,
    'Limit_INR': null,
  },
  {
    'Category': 'Surcharge',
    'Sub-Category': 'On Tax',
    'Income_Slab_INR': '> 10000000',
    'Rate_Percent': 15,
    'Limit_INR': null,
  },
  {
    'Category': 'Surcharge',
    'Sub-Category': 'On Tax',
    'Income_Slab_INR': '> 20000000',
    'Rate_Percent': 25,
    'Limit_INR': null,
  },
  {
    'Category': 'Surcharge',
    'Sub-Category': 'On Tax',
    'Income_Slab_INR': '> 50000000',
    'Rate_Percent': 37,
    'Limit_INR': null,
  },
  {
    'Category': 'Rebate',
    'Sub-Category': 'Tax Rebate (Sec 87A)',
    'Income_Slab_INR': '<= 700000',
    'Rate_Percent': 100,
    'Limit_INR': 25000,
  },
  {
    'Category': 'Cess',
    'Sub-Category': 'Health & Education Cess',
    'Income_Slab_INR': 'On Tax',
    'Rate_Percent': 4,
    'Limit_INR': null,
  },
  {
    'Category': 'Deduction',
    'Sub-Category': 'Standard Deduction',
    'Income_Slab_INR': 'Salaried',
    'Rate_Percent': null,
    'Limit_INR': 50000,
  },
];

// Data sourced from business.csv
final List<Map<String, dynamic>> businessTaxData = [
  {
    'Category': 'Corporate Tax',
    'Sub-Category': 'Domestic Co. (Turnover <= 400 Cr)',
    'Rate_or_Limit': 25,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Corporate Tax',
    'Sub-Category': 'Domestic Co. (Turnover > 400 Cr)',
    'Rate_or_Limit': 30,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Corporate Tax',
    'Sub-Category': 'Domestic Co. (Opted for Sec 115BAA)',
    'Rate_or_Limit': 22,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Corporate Tax',
    'Sub-Category': 'Domestic Co. (Opted for Sec 115BAB)',
    'Rate_or_Limit': 15,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Corporate Tax',
    'Sub-Category': 'Foreign Co.',
    'Rate_or_Limit': 40,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Partnership & LLP',
    'Sub-Category': 'Base Tax Rate',
    'Rate_or_Limit': 30,
    'Income_Threshold_INR': null,
  },
  {
    'Category': 'Partnership & LLP',
    'Sub-Category': 'Surcharge Rate',
    'Rate_or_Limit': 12,
    'Income_Threshold_INR': '> 10000000',
  },
  {
    'Category': 'Corporate Surcharge',
    'Sub-Category': 'Domestic Co',
    'Rate_or_Limit': 7,
    'Income_Threshold_INR': '> 10000000',
  },
  {
    'Category': 'Corporate Surcharge',
    'Sub-Category': 'Domestic Co',
    'Rate_or_Limit': 12,
    'Income_Threshold_INR': '> 100000000',
  },
  {
    'Category': 'Corporate Surcharge',
    'Sub-Category': 'Foreign Co',
    'Rate_or_Limit': 2,
    'Income_Threshold_INR': '> 10000000',
  },
  {
    'Category': 'Corporate Surcharge',
    'Sub-Category': 'Foreign Co',
    'Rate_or_Limit': 5,
    'Income_Threshold_INR': '> 100000000',
  },
  {
    'Category': 'Cess',
    'Sub-Category': 'Health & Education Cess',
    'Rate_or_Limit': 4,
    'Income_Threshold_INR': null,
  },
];
