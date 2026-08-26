/// Centralized validation rules for trip input fields.
/// Keeping these here (instead of inline in widgets) makes rules
/// reusable and easy to unit-test later.
class ValidationService {
  ValidationService._();

  static const int minDays = 1;
  static const int maxDays = 30;

  static const int minTravelers = 1;
  static const int maxTravelers = 20;

  static const double minBudget = 50;
  static const double maxBudget = 1000000;

  /// Destination: required, letters/spaces/commas only, reasonable length.
  static String? validateDestination(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter a destination';
    if (text.length < 2) return 'Destination is too short';
    if (text.length > 50) return 'Destination is too long';

    final validPattern = RegExp(r"^[a-zA-Z\s,.'-]+$");
    if (!validPattern.hasMatch(text)) {
      return 'Use letters only (e.g. Paris, France)';
    }
    return null;
  }

  /// Budget: required, numeric, positive, within a sane range.
  static String? validateBudget(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter your budget';

    final parsed = double.tryParse(text);
    if (parsed == null) return 'Enter a valid number';
    if (parsed < minBudget) {
      return 'Budget should be at least \$${minBudget.toInt()}';
    }
    if (parsed > maxBudget) return 'Budget is unrealistically high';
    return null;
  }

  /// Days: required, integer, within min/max trip length.
  static String? validateDays(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Required';

    final parsed = int.tryParse(text);
    if (parsed == null) return 'Enter a whole number';
    if (parsed < minDays) return 'Min $minDays day';
    if (parsed > maxDays) return 'Max $maxDays days';
    return null;
  }

  /// Travelers: required, integer, within min/max group size.
  static String? validateTravelers(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Required';

    final parsed = int.tryParse(text);
    if (parsed == null) return 'Enter a whole number';
    if (parsed < minTravelers) return 'Min $minTravelers traveler';
    if (parsed > maxTravelers) return 'Max $maxTravelers travelers';
    return null;
  }
}