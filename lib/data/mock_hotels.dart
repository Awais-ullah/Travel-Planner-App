import '../models/hotel_suggestion.dart';

/// Hotel suggestions, keyed by destination name (lowercase).
/// One suggestion per destination, price roughly aligned with
/// that destination's avgHotelCostPerNight in mock_destinations.dart.
class MockHotels {
  MockHotels._();

  static const Map<String, HotelSuggestion> _byDestination = {
    'paris': HotelSuggestion(
      name: 'Hôtel Le Marais',
      category: 'Mid-range',
      pricePerNight: 120,
      rating: 4.3,
    ),
    'tokyo': HotelSuggestion(
      name: 'Shinjuku Central Hotel',
      category: 'Mid-range',
      pricePerNight: 100,
      rating: 4.4,
    ),
    'bali': HotelSuggestion(
      name: 'Ubud Garden Villas',
      category: 'Budget',
      pricePerNight: 60,
      rating: 4.5,
    ),
    'new york': HotelSuggestion(
      name: 'Manhattan Central Inn',
      category: 'Mid-range',
      pricePerNight: 180,
      rating: 4.1,
    ),
    'dubai': HotelSuggestion(
      name: 'Downtown Dubai Suites',
      category: 'Luxury',
      pricePerNight: 150,
      rating: 4.6,
    ),
  };

  static const HotelSuggestion _defaultHotel = HotelSuggestion(
    name: 'City Comfort Hotel',
    category: 'Mid-range',
    pricePerNight: 90,
    rating: 4.0,
  );

  static HotelSuggestion forDestination(String destinationName) {
    final key = destinationName.trim().toLowerCase();
    return _byDestination[key] ?? _defaultHotel;
  }
}