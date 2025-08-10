// backend/lib/backend.dart
library backend;

// Expose only the necessary parts of your library to the outside world.
export 'src/tax_calculator.dart' show calculateTax, getBusinessTypes;
export 'src/models/tax_inputs.dart';
export 'src/models/tax_result.dart';
