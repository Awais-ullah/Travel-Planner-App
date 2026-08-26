import '../data/mock_destinations.dart';
import '../models/destination.dart';
import '../models/itinerary_day.dart';
import '../models/trip_plan.dart';
import '../models/trip_request.dart';

/// Core business logic: turns a TripRequest into a full TripPlan.
/// Pure Dart, no Flutter dependency — easy to test independently of UI.
class TripPlannerService {
  TripPlannerService._();

  // Percentage split of budget across categories when the user's
  // budget comfortably covers the destination's typical costs.
  static const double _hotelShare = 0.40;
  static const double _foodShare = 0.25;
  static const double _transportShare = 0.15;
  static const double _activityShare = 0.20;

  static TripPlan generatePlan(TripRequest request) {
    final destination = MockDestinations.findByName(request.destination);

    final breakdown = _calculateBudgetBreakdown(
      destination: destination,
      request: request,
    );

    final itinerary = _generateItinerary(
      destination: destination,
      days: request.days,
    );

    final estimatedTotal = breakdown.hotel +
        breakdown.food +
        breakdown.transport +
        breakdown.activity;

    return TripPlan(
      destination: destination,
      days: request.days,
      travelers: request.travelers,
      totalBudget: request.budget,
      hotelCost: breakdown.hotel,
      foodCost: breakdown.food,
      transportCost: breakdown.transport,
      activityCost: breakdown.activity,
      estimatedTotalCost: estimatedTotal,
      itinerary: itinerary,
    );
  }

  /// Calculates a budget breakdown two ways:
  /// 1. "Realistic" cost based on the destination's known average daily
  ///    rates, scaled by days and travelers.
  /// 2. If that realistic cost exceeds the user's stated budget, scale
  ///    every category down proportionally so the plan always fits
  ///    within what the user said they can spend.
  static _BudgetBreakdown _calculateBudgetBreakdown({
    required Destination destination,
    required TripRequest request,
  }) {
    final days = request.days;
    final travelers = request.travelers;

    // Hotel is typically booked per room, not per person — assume
    // rooms are shared 2-per-room to keep costs realistic for groups.
    final rooms = (travelers / 2).ceil().clamp(1, travelers);

    final realisticHotel = destination.avgHotelCostPerNight * days * rooms;
    final realisticFood = destination.avgFoodCostPerDay * days * travelers;
    final realisticTransport =
        destination.avgTransportCostPerDay * days * travelers;
    final realisticActivity =
        destination.avgActivityCostPerDay * days * travelers;

    final realisticTotal =
        realisticHotel + realisticFood + realisticTransport + realisticActivity;

    if (realisticTotal <= request.budget || realisticTotal == 0) {
      // Budget comfortably covers realistic costs — use them as-is.
      return _BudgetBreakdown(
        hotel: realisticHotel,
        food: realisticFood,
        transport: realisticTransport,
        activity: realisticActivity,
      );
    }

    // Budget is tighter than realistic costs — scale everything down
    // proportionally so categories still sum to (roughly) the budget,
    // while preserving the relative share between categories.
    final scaleFactor = request.budget / realisticTotal;

    return _BudgetBreakdown(
      hotel: realisticHotel * scaleFactor,
      food: realisticFood * scaleFactor,
      transport: realisticTransport * scaleFactor,
      activity: realisticActivity * scaleFactor,
    );
  }

  /// Builds a simple day-by-day itinerary. Alternates activity themes
  /// so the plan doesn't feel repetitive across multiple days.
  static List<ItineraryDay> _generateItinerary({
    required Destination destination,
    required int days,
  }) {
    final themes = <String>[
      'Arrival & Local Exploration',
      'Sightseeing & Landmarks',
      'Culture & Cuisine',
      'Leisure & Relaxation',
      'Adventure & Activities',
      'Shopping & Local Markets',
      'Free Day / Departure',
    ];

    return List.generate(days, (index) {
      final dayNumber = index + 1;
      final theme = themes[index % themes.length];

      final activities = _activitiesForTheme(theme, destination.name);

      return ItineraryDay(
        dayNumber: dayNumber,
        title: 'Day $dayNumber: $theme',
        activities: activities,
      );
    });
  }

  static List<String> _activitiesForTheme(String theme, String destinationName) {
    switch (theme) {
      case 'Arrival & Local Exploration':
        return [
          'Check in to hotel and settle in',
          'Take a short walk around the neighborhood',
          'Enjoy a welcome dinner at a local restaurant',
        ];
      case 'Sightseeing & Landmarks':
        return [
          'Visit the top attractions in $destinationName',
          'Guided or self-guided city tour',
          'Photo stops at major landmarks',
        ];
      case 'Culture & Cuisine':
        return [
          'Explore a local market or food street',
          'Try a signature regional dish',
          'Visit a museum or cultural site',
        ];
      case 'Leisure & Relaxation':
        return [
          'Relax at a beach, park, or spa',
          'Casual lunch at a nearby café',
          'Free time to explore independently',
        ];
      case 'Adventure & Activities':
        return [
          'Join an outdoor or adventure activity',
          'Explore nature spots or excursions nearby',
          'Evening leisure or entertainment',
        ];
      case 'Shopping & Local Markets':
        return [
          'Browse local shops and markets',
          'Pick up souvenirs',
          'Relaxed dinner to wrap up the day',
        ];
      default: // Free Day / Departure
        return [
          'Last-minute sightseeing or shopping',
          'Pack and check out of hotel',
          'Depart for the airport/station',
        ];
    }
  }
}

/// Internal helper struct for passing breakdown values around.
class _BudgetBreakdown {
  const _BudgetBreakdown({
    required this.hotel,
    required this.food,
    required this.transport,
    required this.activity,
  });

  final double hotel;
  final double food;
  final double transport;
  final double activity;
}