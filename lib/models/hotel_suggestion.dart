/// A hotel suggestion shown on the Trip Details screen.
class HotelSuggestion {
  const HotelSuggestion({
    required this.name,
    required this.category,
    required this.pricePerNight,
    required this.rating,
  });

  final String name;

  /// e.g. "Budget", "Mid-range", "Luxury"
  final String category;

  final double pricePerNight;

  /// Out of 5.0
  final double rating;
}