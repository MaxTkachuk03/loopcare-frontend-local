import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_image_data.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_gallery_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SubscriptionGallery extends StatefulWidget {
  final List<SubscriptionImageData> images;

  const SubscriptionGallery({super.key, required this.images});

  @override
  State<SubscriptionGallery> createState() => _SubscriptionGalleryState();
}

class _SubscriptionGalleryState extends State<SubscriptionGallery> {
  final _controller = PageController();
  final _progressPageListener = ValueNotifier<double?>(null);

  int get count => widget.images.isEmpty ? 1 : widget.images.length;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _progressPageListener.value = _controller.page;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressPageListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 130,
        maxHeight: 380,
        minWidth: double.infinity,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: PageView.builder(
              padEnds: false,
              controller: _controller,
              itemCount: count,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<double?>(
                  valueListenable: _progressPageListener,
                  builder: (context, value, child) {
                    final opacity = (1 - (index - (value ?? 0.0)).abs() * 4).clamp(0.0, 1.0);
                    return Opacity(
                      opacity: opacity,
                      child: child!,
                    );
                  },
                  child: widget.images.isNotEmpty
                      ? SubscriptionGalleryCard(
                          url: widget.images[index].url,
                          title: widget.images[index].title,
                          label: widget.images[index].label,
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: count,
              effect: const ColorTransitionEffect(
                activeDotColor: AppColors.blueLighter,
                dotColor: AppColors.greyLighter,
                dotHeight: 8.0,
                dotWidth: 8.0,
              ),
              onDotClicked: _controller.jumpToPage,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
