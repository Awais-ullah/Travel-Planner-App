import '../models/place.dart';

/// Places-to-visit recommendations, keyed by destination name (lowercase).
/// A generic fallback list is used for destinations not covered here.
class MockPlaces {
  MockPlaces._();

  static const Map<String, List<Place>> _byDestination = {
    'paris': [
      Place(name: 'Eiffel Tower', description: 'Iconic iron landmark with city views.', icon: 'landmark'),
      Place(name: 'Louvre Museum', description: 'Home to the Mona Lisa and thousands of artworks.', icon: 'museum'),
      Place(name: 'Montmartre', description: 'Historic hilltop district with artist charm.', icon: 'hill'),
      Place(name: 'Seine River Cruise', description: 'Scenic boat ride past the city\'s landmarks.', icon: 'boat'),
    ],
    'tokyo': [
      Place(name: 'Senso-ji Temple', description: 'Ancient Buddhist temple in Asakusa.', icon: 'temple'),
      Place(name: 'Shibuya Crossing', description: 'The world\'s busiest pedestrian crossing.', icon: 'city'),
      Place(name: 'Tokyo Tower', description: 'Panoramic views of the city skyline.', icon: 'tower'),
      Place(name: 'Akihabara', description: 'Electronics and anime culture district.', icon: 'store'),
    ],
    'bali': [
      Place(name: 'Ubud Rice Terraces', description: 'Iconic lush green terraced landscapes.', icon: 'terrace'),
      Place(name: 'Uluwatu Temple', description: 'Clifftop temple with ocean sunset views.', icon: 'temple'),
      Place(name: 'Seminyak Beach', description: 'Popular beach with beach clubs and surf.', icon: 'beach'),
      Place(name: 'Tegallalang', description: 'Scenic rice paddies and swings.', icon: 'terrace'),
    ],
    'new york': [
      Place(name: 'Central Park', description: 'Sprawling green escape in Manhattan.', icon: 'park'),
      Place(name: 'Times Square', description: 'Bright lights and buzzing energy.', icon: 'city'),
      Place(name: 'Statue of Liberty', description: 'Iconic symbol of freedom on Liberty Island.', icon: 'landmark'),
      Place(name: 'Brooklyn Bridge', description: 'Historic bridge with stunning skyline views.', icon: 'bridge'),
    ],
    'dubai': [
      Place(name: 'Burj Khalifa', description: 'The world\'s tallest building.', icon: 'tower'),
      Place(name: 'Dubai Mall', description: 'One of the largest malls in the world.', icon: 'store'),
      Place(name: 'Desert Safari', description: 'Dune bashing and desert camp experience.', icon: 'desert'),
      Place(name: 'Palm Jumeirah', description: 'Iconic man-made palm-shaped island.', icon: 'island'),
    ],
  };

  static const List<Place> _defaultPlaces = [
    Place(name: 'City Center', description: 'Explore the heart of the destination.', icon: 'city'),
    Place(name: 'Local Market', description: 'Sample local goods and street food.', icon: 'store'),
    Place(name: 'Historic Landmark', description: 'A must-see cultural landmark.', icon: 'landmark'),
    Place(name: 'Scenic Viewpoint', description: 'Great spot for photos and views.', icon: 'hill'),
  ];

  static List<Place> forDestination(String destinationName) {
    final key = destinationName.trim().toLowerCase();
    return _byDestination[key] ?? _defaultPlaces;
  }
}