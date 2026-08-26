/// Extended information shown on the Place Detail screen — separate from
/// the lightweight `Place` model (used in list cards) to keep that model
/// small for the Trip Details list.
class PlaceDetail {
  const PlaceDetail({
    required this.images,
    required this.fullDescription,
    required this.highlights,
    required this.bestTimeToVisit,
    required this.estimatedDuration,
    required this.entryFee,
  });

  /// Static placeholder image URLs (no API key required).
  final List<String> images;

  final String fullDescription;

  /// Short tag-style highlights, e.g. "Photo spot", "Family friendly".
  final List<String> highlights;

  final String bestTimeToVisit;
  final String estimatedDuration;

  /// Display string, e.g. "Free", "\$15", "Varies".
  final String entryFee;
}