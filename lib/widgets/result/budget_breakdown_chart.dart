import 'package:flutter/material.dart';
import '../../models/trip_plan.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Visual budget breakdown using simple proportional bars — no chart
/// package needed, keeps the "avoid unnecessary packages" rule intact.
class BudgetBreakdownChart extends StatelessWidget {
  const BudgetBreakdownChart({super.key, required this.plan});

  final TripPlan plan;

  @override
  Widget build(BuildContext context) {
    final total = plan.estimatedTotalCost <= 0 ? 1.0 : plan.estimatedTotalCost;

    final categories = [
      _Category('Hotel', plan.hotelCost, AppColors.hotelColor, Icons.hotel_outlined),
      _Category('Food', plan.foodCost, AppColors.foodColor, Icons.restaurant_outlined),
      _Category('Transport', plan.transportCost, AppColors.transportColor, Icons.directions_bus_outlined),
      _Category('Activities', plan.activityCost, AppColors.activityColor, Icons.local_activity_outlined),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Budget Breakdown', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.md),
            // Stacked proportional bar
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              child: SizedBox(
                height: 12,
                child: Row(
                  children: categories.map((c) {
                    final fraction = total == 0 ? 0.0 : (c.amount / total);
                    return Expanded(
                      flex: (fraction * 1000).round().clamp(1, 1000),
                      child: Container(color: c.color),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...categories.map((c) => _BreakdownRow(category: c, total: total)),
          ],
        ),
      ),
    );
  }
}

class _Category {
  const _Category(this.label, this.amount, this.color, this.icon);
  final String label;
  final double amount;
  final Color color;
  final IconData icon;
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.category, required this.total});

  final _Category category;
  final double total;

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : (category.amount / total * 100);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: category.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(category.icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(category.label, style: AppTextStyles.body),
          ),
          Text(
            '\$${category.amount.toStringAsFixed(0)}',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 40,
            child: Text(
              '${percent.toStringAsFixed(0)}%',
              textAlign: TextAlign.right,
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}