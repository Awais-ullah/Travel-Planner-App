import 'package:flutter/material.dart';
import '../../models/trip_plan.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Top summary card on the Result screen: total budget, estimated cost,
/// and remaining balance at a glance.
class BudgetSummaryCard extends StatelessWidget {
  const BudgetSummaryCard({super.key, required this.plan});

  final TripPlan plan;

  String _money(double value) => '\$${value.toStringAsFixed(0)}';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trip Summary', style: AppTextStyles.title),
                if (plan.isBudgetConstrained)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      'Budget-tight',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _StatColumn(
                    label: 'Your Budget',
                    value: _money(plan.totalBudget),
                    color: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: _StatColumn(
                    label: 'Estimated Cost',
                    value: _money(plan.estimatedTotalCost),
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _StatColumn(
                    label: 'Remaining',
                    value: _money(plan.remainingBudget),
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg * 1.5),
            Row(
              children: [
                Expanded(
                  child: _InfoRow(icon: Icons.calendar_today_outlined, label: '${plan.days} days'),
                ),
                Expanded(
                  child: _InfoRow(icon: Icons.people_outline, label: '${plan.travelers} travelers'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.title.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(label, style: AppTextStyles.bodySecondary, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}