import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Swipeable image carousel with dot indicators. Accepts a list of
/// image sources that may still be resolving (see PlaceDetailScreen),
/// so each slot shows its own loading/placeholder state independently.
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.imageUrls, this.height = 260});

  /// Null entries render as a placeholder (still loading or unavailable)
  /// instead of skipping the slot, so the dot count stays stable.
  final List<String?> imageUrls;
  final double height;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return _ImagePlaceholder(height: widget.height);
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: SizedBox(
            height: widget.height,
            width: double.infinity,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final url = widget.imageUrls[index];
                if (url == null) {
                  return _ImagePlaceholder(height: widget.height, isLoading: true);
                }
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return _ImagePlaceholder(height: widget.height, isLoading: true);
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      _ImagePlaceholder(height: widget.height),
                );
              },
            ),
          ),
        ),
        if (widget.imageUrls.length > 1) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.divider,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.height, this.isLoading = false});

  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: AppColors.primaryLight,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(strokeWidth: 2)
            : const Icon(Icons.image_outlined, size: 40, color: AppColors.primary),
      ),
    );
  }
}