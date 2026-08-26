/// Represents a supported travel destination with average daily costs
/// used by TripPlannerService (Step 7) to generate a budget breakdown.
class Destination {
  const Destination({
    required this.name,
    required this.country,
    required this.icon,
    required this.avgHotelCostPerNight,
    required this.avgFoodCostPerDay,
    required this.avgTransportCostPerDay,
    required this.avgActivityCostPerDay,
    required this.description,
  });

  final String name;
  final String country;

  /// Material icon codePoint-free reference; using IconData directly
  /// would require importing material.dart into a "pure" model,
  /// so we store an icon key and map it in the UI layer instead.
  final String icon;

  final double avgHotelCostPerNight;
  final double avgFoodCostPerDay;
  final double avgTransportCostPerDay;
  final double avgActivityCostPerDay;

  final String description;

  /// Rough per-day cost for a single traveler, used as a baseline
  /// before scaling by traveler count and actual budget in Step 7.
  double get avgCostPerDayPerPerson =>
      avgHotelCostPerNight +
          avgFoodCostPerDay +
          avgTransportCostPerDay +
          avgActivityCostPerDay;
}