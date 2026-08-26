import 'package:flutter/material.dart';
import '../../data/mock_place_details.dart';
import '../../models/place.dart';
import '../../services/place_image_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/icon_mapper.dart';
import '../../widgets/common/responsive_scaffold_body.dart';
import '../../widgets/details/image_carousel.dart';

/// Full detail view for a single place: real photo (fetched from
/// Wikipedia by name), description, and useful visit info.
class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late Future<String?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = PlaceImageService.fetchImageUrl(widget.place.name);
  }

  @override
  Widget build(BuildContext context) {
    final detail = MockPlaceDetails.forPlace(widget.place.name);

    return Scaffold(
      appBar: AppBar(title: Text(widget.place.name)),
      body: SafeArea(
        child: ResponsiveScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              FutureBuilder<String?>(
                future: _imageFuture,
                builder: (context, snapshot) {
                  final isWaiting = snapshot.connectionState == ConnectionState.waiting;
                  final fetchedUrl = snapshot.data;

                  return ImageCarousel(
                    imageUrls: [
                      if (isWaiting) null else fetchedUrl,
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(IconMapper.resolve(widget.place.icon), color: AppColors.primary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(widget.place.name, style: AppTextStyles.headline),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: detail.highlights.map((h) => _HighlightChip(label: h)).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('About', style: AppTextStyles.title),
              const SizedBox(height: AppSpacing.xs),
              Text(detail.fullDescription, style: AppTextStyles.body),
              const SizedBox(height: AppSpacing.lg),
              Text('Visit Info', style: AppTextStyles.title),
              const SizedBox(height: AppSpacing.sm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.schedule_outlined,
                        label: 'Best time to visit',
                        value: detail.bestTimeToVisit,
                      ),
                      const Divider(height: AppSpacing.lg),
                      _InfoRow(
                        icon: Icons.timelapse_outlined,
                        label: 'Suggested duration',
                        value: detail.estimatedDuration,
                      ),
                      const Divider(height: AppSpacing.lg),
                      _InfoRow(
                        icon: Icons.confirmation_number_outlined,
                        label: 'Entry fee',
                        value: detail.entryFee,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightChip extends StatelessWidget {
  const _HighlightChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(label, style: AppTextStyles.bodySecondary),
        ),
        Text(
          value,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}