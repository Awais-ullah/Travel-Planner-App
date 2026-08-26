/// Simple transport info text, keyed by destination name (lowercase).
/// Kept as plain data (not a full model) since it's just descriptive text.
class MockTransport {
  MockTransport._();

  static const Map<String, String> _byDestination = {
    'paris': 'Metro and buses cover the city well. Consider a weekly transit pass for unlimited rides.',
    'tokyo': 'Extensive train and subway network. A Suica/Pasmo card makes transit fast and easy.',
    'bali': 'Scooter rental or private driver is most convenient; ride-hailing apps work in main areas.',
    'new york': 'Subway runs 24/7 and covers most of the city; yellow cabs and rideshare are widely available.',
    'dubai': 'Modern metro system plus affordable taxis; rideshare apps are widely used.',
  };

  static const String _defaultInfo =
      'Local buses, taxis, and rideshare apps are typically available to get around.';

  static String forDestination(String destinationName) {
    final key = destinationName.trim().toLowerCase();
    return _byDestination[key] ?? _defaultInfo;
  }
}