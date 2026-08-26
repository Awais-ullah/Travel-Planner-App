import 'package:flutter/material.dart';
import 'package:travel_planner_app/screens/trip_result_screen.dart';
import '../../models/trip_request.dart';
import '../../services/trip_planner_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/responsive_scaffold_body.dart';
import '../widgets/common/dismiss_keyboard.dart';
import '../widgets/trip_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleFormSubmit(
      BuildContext context, {
        required String destination,
        required String budget,
        required String days,
        required String travelers,
      }) {
    final parsedBudget = double.tryParse(budget);
    final parsedDays = int.tryParse(days);
    final parsedTravelers = int.tryParse(travelers);

    if (parsedBudget == null || parsedDays == null || parsedTravelers == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please check your inputs.')),
      );
      return;
    }

    final request = TripRequest(
      destination: destination,
      budget: parsedBudget,
      days: parsedDays,
      travelers: parsedTravelers,
    );

    final plan = TripPlannerService.generatePlan(request);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TripResultScreen(plan: plan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyboard(
        child: SafeArea(
          child: ResponsiveScaffoldBody(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _HomeHeader(),
                  const SizedBox(height: AppSpacing.lg),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: TripForm(
                        onSubmit: ({
                          required destination,
                          required budget,
                          required days,
                          required travelers,
                        }) {
                          _handleFormSubmit(
                            context,
                            destination: destination,
                            budget: budget,
                            days: days,
                            travelers: travelers,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _InfoStrip(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.flight_takeoff_rounded, color: Colors.white, size: 32),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Where to next?',
            style: AppTextStyles.headline.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Tell us your trip details and we\'ll build your plan.',
            style: AppTextStyles.bodySecondary.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoStrip extends StatelessWidget {
  const _InfoStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _InfoItem(icon: Icons.hotel_outlined, label: 'Hotels'),
        _InfoItem(icon: Icons.restaurant_outlined, label: 'Food'),
        _InfoItem(icon: Icons.directions_bus_outlined, label: 'Transport'),
        _InfoItem(icon: Icons.map_outlined, label: 'Places'),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}