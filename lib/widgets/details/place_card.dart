import 'package:flutter/material.dart';
import '../../models/place.dart';
import '../../screens/place_detail/place_detail_screen.dart';
import '../../services/place_image_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../common/icon_mapper.dart';

/// Displays one place-to-visit recommendation with a small live thumbnail.
/// Tapping navigates to the full PlaceDetailScreen.
class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: FutureBuilder<String?>(
                    future: PlaceImageService.fetchImageUrl(place.name),
                    builder: (context, snapshot) {
                      final url = snapshot.data;
                      if (url == null) {
                        return CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(IconMapper.resolve(place.icon), color: AppColors.primary),
                        );
                      }
                      return Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(IconMapper.resolve(place.icon), color: AppColors.primary),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name, style: AppTextStyles.title),
                    const SizedBox(height: 4),
                    Text(place.description, style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}