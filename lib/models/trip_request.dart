/// Parsed, validated user input from the Home Screen form.
/// Constructed only after ValidationService confirms the raw text
/// is well-formed, so fields here are already safe numeric types.
class TripRequest {
  const TripRequest({
    required this.destination,
    required this.budget,
    required this.days,
    required this.travelers,
  });

  final String destination;
  final double budget;
  final int days;
  final int travelers;
}