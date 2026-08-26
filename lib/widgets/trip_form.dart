import 'package:flutter/material.dart';
import 'package:travel_planner_app/widgets/primary_button.dart';
import '../../services/validation_service.dart';
import '../../theme/app_spacing.dart';
import 'app_text_field.dart';

/// The input form on the Home Screen: destination, budget, days, travelers.
class TripForm extends StatefulWidget {
  const TripForm({super.key, required this.onSubmit});

  final void Function({
  required String destination,
  required String budget,
  required String days,
  required String travelers,
  }) onSubmit;

  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final _formKey = GlobalKey<FormState>();

  final _destinationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _daysController = TextEditingController();
  final _travelersController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _destinationController.dispose();
    _budgetController.dispose();
    _daysController.dispose();
    _travelersController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return; // guard against double-tap

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSubmitting = true);

    // Brief, deliberate delay so the action feels acknowledged rather
    // than instantaneous-to-the-point-of-feeling-unresponsive.
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    widget.onSubmit(
      destination: _destinationController.text.trim(),
      budget: _budgetController.text.trim(),
      days: _daysController.text.trim(),
      travelers: _travelersController.text.trim(),
    );

    if (mounted) setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Destination',
            hint: 'e.g. Paris, Bali, Tokyo',
            icon: Icons.location_on_outlined,
            controller: _destinationController,
            keyboardType: TextInputType.text,
            validator: ValidationService.validateDestination,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Budget (USD)',
            hint: 'e.g. 1500',
            icon: Icons.account_balance_wallet_outlined,
            controller: _budgetController,
            keyboardType: TextInputType.number,
            validator: ValidationService.validateBudget,
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final daysField = AppTextField(
                label: 'Days',
                hint: 'e.g. 5',
                icon: Icons.calendar_today_outlined,
                controller: _daysController,
                keyboardType: TextInputType.number,
                validator: ValidationService.validateDays,
              );
              final travelersField = AppTextField(
                label: 'Travelers',
                hint: 'e.g. 2',
                icon: Icons.people_outline,
                controller: _travelersController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: ValidationService.validateTravelers,
              );

              if (constraints.maxWidth < 340) {
                return Column(
                  children: [
                    daysField,
                    const SizedBox(height: AppSpacing.md),
                    travelersField,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: daysField),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: travelersField),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: _isSubmitting ? 'Planning...' : 'Plan My Trip',
            icon: _isSubmitting ? null : Icons.travel_explore_rounded,
           
            onPressed: _isSubmitting ? null : _handleSubmit,
          ),
        ],
      ),
    );
  }
}