import 'package:flutter/material.dart';
import 'package:travel_planner_app/screens/trip_details_screen.dart';
import '../../models/trip_plan.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
// import '../../widgets/common/primary_button.dart';
import '../../widgets/result/budget_breakdown_chart.dart';
import '../../widgets/result/budget_summary_card.dart';
import '../../widgets/result/itinerary_day_card.dart';
// import '../trip_details/trip_details_screen.dart';
import '../widgets/common/nav_helper.dart';
import '../widgets/common/responsive_scaffold_body.dart';
import '../widgets/primary_button.dart';
import 'package:flutter/material.dart';


/// Displays the generated trip plan: summary, budget breakdown,
/// and full day-by-day itinerary.
class TripResultScreen extends StatelessWidget {
  const TripResultScreen({super.key, required this.plan});

  final TripPlan plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(plan.destination.name),
        actions: [
          IconButton(
            tooltip: 'Plan a new trip',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => NavHelper.backToHome(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveScaffoldBody(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Your Trip Plan', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.xs),
            Text(
              plan.destination.description,
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            BudgetSummaryCard(plan: plan),
            const SizedBox(height: AppSpacing.md),
            BudgetBreakdownChart(plan: plan),
            const SizedBox(height: AppSpacing.lg),
            Text('Daily Itinerary', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.sm),
            ...plan.itinerary.map(
                  (day) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ItineraryDayCard(day: day),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'View Trip Details',
              icon: Icons.info_outline,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TripDetailsScreen(plan: plan),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
      ),
    );
  }
}