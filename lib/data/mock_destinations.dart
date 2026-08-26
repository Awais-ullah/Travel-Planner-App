import '../models/destination.dart';

/// Static list of supported destinations with average cost data.
/// Since the Home Screen destination field is free text, lookups are
/// case-insensitive and fall back to [defaultDestination] for any
/// place not in this list — so the app always produces a plan.
class MockDestinations {
  MockDestinations._();

  static const List<Destination> all = [
    Destination(
      name: 'Paris',
      country: 'France',
      icon: 'landmark',
      avgHotelCostPerNight: 120,
      avgFoodCostPerDay: 55,
      avgTransportCostPerDay: 20,
      avgActivityCostPerDay: 35,
      description:
      'The City of Light — iconic landmarks, world-class art, and café culture.',
    ),
    Destination(
      name: 'Tokyo',
      country: 'Japan',
      icon: 'temple',
      avgHotelCostPerNight: 100,
      avgFoodCostPerDay: 45,
      avgTransportCostPerDay: 15,
      avgActivityCostPerDay: 30,
      description:
      'A vibrant blend of ultramodern skylines and traditional temples.',
    ),
    Destination(
      name: 'Bali',
      country: 'Indonesia',
      icon: 'beach',
      avgHotelCostPerNight: 60,
      avgFoodCostPerDay: 25,
      avgTransportCostPerDay: 10,
      avgActivityCostPerDay: 20,
      description:
      'Tropical beaches, lush rice terraces, and a relaxed island vibe.',
    ),
    Destination(
      name: 'New York',
      country: 'USA',
      icon: 'city',
      avgHotelCostPerNight: 180,
      avgFoodCostPerDay: 60,
      avgTransportCostPerDay: 25,
      avgActivityCostPerDay: 40,
      description:
      'The city that never sleeps — skyscrapers, Broadway, and world cuisine.',
    ),
    Destination(
      name: 'Dubai',
      country: 'UAE',
      icon: 'skyline',
      avgHotelCostPerNight: 150,
      avgFoodCostPerDay: 50,
      avgTransportCostPerDay: 20,
      avgActivityCostPerDay: 45,
      description:
      'Futuristic architecture, luxury shopping, and desert adventures.',
    ),
  ];

  /// Generic fallback used when the user types a destination that
  /// isn't in [all]. Keeps the app fully functional on any input.
  static const Destination defaultDestination = Destination(
    name: 'Your Destination',
    country: '',
    icon: 'globe',
    avgHotelCostPerNight: 90,
    avgFoodCostPerDay: 40,
    avgTransportCostPerDay: 15,
    avgActivityCostPerDay: 25,
    description: 'A curated trip plan based on typical travel costs.',
  );

  /// Case-insensitive, whitespace-trimmed lookup by name.
  /// Falls back to a copy of [defaultDestination] carrying the user's
  /// original input as the display name, so the UI still shows
  /// what they typed instead of a generic placeholder.
  static Destination findByName(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return defaultDestination;

    for (final destination in all) {
      if (destination.name.toLowerCase() == normalized) {
        return destination;
      }
    }

    return Destination(
      name: query.trim(),
      country: defaultDestination.country,
      icon: defaultDestination.icon,
      avgHotelCostPerNight: defaultDestination.avgHotelCostPerNight,
      avgFoodCostPerDay: defaultDestination.avgFoodCostPerDay,
      avgTransportCostPerDay: defaultDestination.avgTransportCostPerDay,
      avgActivityCostPerDay: defaultDestination.avgActivityCostPerDay,
      description: defaultDestination.description,
    );
  }
}