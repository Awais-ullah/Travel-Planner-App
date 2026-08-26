import 'package:flutter/material.dart';
import '../../models/itinerary_day.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Displays one day's plan as a card with a numbered badge and
/// a bulleted list of that day's activities.
class ItineraryDayCard extends StatelessWidget {
  const ItineraryDayCard({super.key, required this.day});

  final ItineraryDay day;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    '${day.dayNumber}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    day.title,
                    style: AppTextStyles.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...day.activities.map(
                  (activity) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 6, color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(activity, style: AppTextStyles.body)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}