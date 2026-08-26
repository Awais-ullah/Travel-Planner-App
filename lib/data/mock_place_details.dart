import '../models/place_detail.dart';

/// Extended place info, keyed by place name (lowercase).
/// Falls back to generic-but-complete info + a seeded placeholder image
/// for any place not explicitly listed, so the detail screen never shows
/// broken images or empty sections.
class MockPlaceDetails {
  MockPlaceDetails._();

  static List<String> _placeholderImages(String seed) => [
    'https://picsum.photos/seed/$seed-1/800/600',
    'https://picsum.photos/seed/$seed-2/800/600',
    'https://picsum.photos/seed/$seed-3/800/600',
  ];

  static final Map<String, PlaceDetail> _byPlace = {
    'eiffel tower': PlaceDetail(
      images: _placeholderImages('eiffel-tower'),
      fullDescription:
      'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars, '
          'built in 1889. It offers three viewing levels, with the top level '
          'providing sweeping panoramic views across Paris. It is especially '
          'popular at sunset and after dark, when it sparkles on the hour.',
      highlights: const ['Iconic landmark', 'Photo spot', 'Night lights show'],
      bestTimeToVisit: 'Early morning or sunset',
      estimatedDuration: '2–3 hours',
      entryFee: '\$20 (summit access)',
    ),
    'louvre museum': PlaceDetail(
      images: _placeholderImages('louvre'),
      fullDescription:
      'The world\'s largest art museum, home to thousands of works '
          'including the Mona Lisa and the Venus de Milo. Housed in a former '
          'royal palace, the museum spans several wings covering art from '
          'antiquity to the 19th century.',
      highlights: const ['World-famous art', 'Historic palace', 'Indoor'],
      bestTimeToVisit: 'Weekday mornings',
      estimatedDuration: '3–4 hours',
      entryFee: '\$17',
    ),
    'montmartre': PlaceDetail(
      images: _placeholderImages('montmartre'),
      fullDescription:
      'A historic hilltop district known for its bohemian past, artist '
          'studios, and the white-domed Sacré-Cœur Basilica. Wander cobbled '
          'streets, browse street artists at Place du Tertre, and enjoy '
          'skyline views over Paris.',
      highlights: const ['Scenic views', 'Artsy neighborhood', 'Walkable'],
      bestTimeToVisit: 'Late afternoon',
      estimatedDuration: '2–3 hours',
      entryFee: 'Free (basilica entry free)',
    ),
    'senso-ji temple': PlaceDetail(
      images: _placeholderImages('sensoji'),
      fullDescription:
      'Tokyo\'s oldest Buddhist temple, founded in 645 AD. The approach '
          'through Nakamise shopping street is lined with traditional snacks '
          'and souvenirs, leading to the iconic Kaminarimon "Thunder Gate".',
      highlights: const ['Historic temple', 'Traditional market street'],
      bestTimeToVisit: 'Early morning to avoid crowds',
      estimatedDuration: '1–2 hours',
      entryFee: 'Free',
    ),
    'shibuya crossing': PlaceDetail(
      images: _placeholderImages('shibuya'),
      fullDescription:
      'The world\'s busiest pedestrian scramble crossing, with up to '
          '3,000 people crossing at once when the light changes. Surrounded '
          'by giant video screens and neon signage — a quintessential Tokyo '
          'experience, especially at night.',
      highlights: const ['Iconic city scene', 'Great for photos', 'Nightlife nearby'],
      bestTimeToVisit: 'Evening (neon lights)',
      estimatedDuration: '30–60 minutes',
      entryFee: 'Free',
    ),
  };

  static final PlaceDetail _defaultDetail = PlaceDetail(
    images: _placeholderImages('travel-default'),
    fullDescription:
    'A notable spot worth visiting on your trip. Check local guides or '
        'ask your hotel concierge for the latest visiting hours and tips '
        'specific to this location.',
    highlights: const ['Worth visiting', 'Local favorite'],
    bestTimeToVisit: 'Varies — check locally',
    estimatedDuration: '1–2 hours',
    entryFee: 'Varies',
  );

  static PlaceDetail forPlace(String placeName) {
    final key = placeName.trim().toLowerCase();
    return _byPlace[key] ?? _defaultDetail;
  }
}