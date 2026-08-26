/// A single day's plan within the itinerary.
class ItineraryDay {
  const ItineraryDay({
    required this.dayNumber,
    required this.title,
    required this.activities,
  });

  final int dayNumber;
  final String title;
  final List<String> activities;
}