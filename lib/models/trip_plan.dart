import 'destination.dart';
import 'itinerary_day.dart';

/// The fully generated trip plan, produced by TripPlannerService.
/// This is the single object passed from Home -> Result -> Details screens.
class TripPlan {
  const TripPlan({
    required this.destination,
    required this.days,
    required this.travelers,
    required this.totalBudget,
    required this.hotelCost,
    required this.foodCost,
    required this.transportCost,
    required this.activityCost,
    required this.estimatedTotalCost,
    required this.itinerary,
  });

  final Destination destination;
  final int days;
  final int travelers;

  /// The budget the user originally entered.
  final double totalBudget;

  // Budget breakdown (scaled to fit within totalBudget — see service).
  final double hotelCost;
  final double foodCost;
  final double transportCost;
  final double activityCost;

  /// Sum of the four breakdown categories. May be <= totalBudget.
  final double estimatedTotalCost;

  final List<ItineraryDay> itinerary;

  /// Remaining budget after estimated costs (never negative by design).
  double get remainingBudget =>
      (totalBudget - estimatedTotalCost).clamp(0, double.infinity);

  /// Whether the requested budget was tight enough that costs were
  /// scaled down from the destination's typical averages.
  bool get isBudgetConstrained => estimatedTotalCost >= totalBudget * 0.99;
}