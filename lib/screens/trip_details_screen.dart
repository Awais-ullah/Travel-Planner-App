import 'package:flutter/material.dart';
import '../../data/mock_food.dart';
import '../../data/mock_hotels.dart';
import '../../data/mock_places.dart';
import '../../data/mock_transport.dart';
import '../../models/trip_plan.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/responsive_utils.dart';
import '../../widgets/common/nav_helper.dart';

import '../../widgets/common/responsive_scaffold_body.dart';

import '../../widgets/details/food_card.dart';
import '../../widgets/details/hotel_card.dart';
import '../../widgets/details/place_card.dart';
import '../../widgets/details/transport_info_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_title.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key, required this.plan});

  final TripPlan plan;

  @override
  Widget build(BuildContext context) {
    final destinationName = plan.destination.name;

    final places = MockPlaces.forDestination(destinationName);
    final foodItems = MockFood.forDestination(destinationName);
    final hotel = MockHotels.forDestination(destinationName);
    final transportInfo = MockTransport.forDestination(destinationName);

    final columns = ResponsiveUtils.gridColumns(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
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
              Text(destinationName, style: AppTextStyles.headline),
              const SizedBox(height: AppSpacing.xs),
              Text(plan.destination.description, style: AppTextStyles.bodySecondary),
              const SizedBox(height: AppSpacing.lg),

              const SectionTitle(title: 'Places to Visit'),
              const SizedBox(height: AppSpacing.sm),
              _ResponsiveCardGrid(
                columns: columns,
                children: places.map((p) => PlaceCard(place: p)).toList(),
              ),
              const SizedBox(height: AppSpacing.md),

              const SectionTitle(title: 'Food Recommendations'),
              const SizedBox(height: AppSpacing.sm),
              _ResponsiveCardGrid(
                columns: columns,
                children: foodItems.map((f) => FoodCard(foodItem: f)).toList(),
              ),
              const SizedBox(height: AppSpacing.md),

              const SectionTitle(title: 'Hotel Suggestion'),
              const SizedBox(height: AppSpacing.sm),
              HotelCard(hotel: hotel),
              const SizedBox(height: AppSpacing.md),

              const SectionTitle(title: 'Transport'),
              const SizedBox(height: AppSpacing.sm),
              TransportInfoCard(info: transportInfo),
              const SizedBox(height: AppSpacing.lg),

              PrimaryButton(
                label: 'Plan Another Trip',
                icon: Icons.refresh_rounded,
                onPressed: () => NavHelper.backToHome(context),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lays out cards in a single column on phones, or a responsive grid
/// on tablet/desktop widths. Uses Wrap instead of GridView so each
/// card can size to its own content height (cards have variable text length).
class _ResponsiveCardGrid extends StatelessWidget {
  const _ResponsiveCardGrid({required this.columns, required this.children});

  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        children: children
            .map((c) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: c,
        ))
            .toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = AppSpacing.sm;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((c) => SizedBox(width: itemWidth, child: c))
              .toList(),
        );
      },
    );
  }
}