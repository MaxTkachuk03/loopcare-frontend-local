import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loopcare_frontend/core/presentation/animations/lottie_animation.dart';
import 'package:loopcare_frontend/core/presentation/cards/custom_tappable_card.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:visibility_detector/visibility_detector.dart';

const _itemHeight = 120.0;
const _borderRadius = BorderRadius.all(Radius.circular(16));

class GoalCategoryCard extends StatefulWidget {
  final void Function(SmartGoalCategory value) onPressed;
  final void Function() onUnlocked;
  final SmartGoalCategory category;

  const GoalCategoryCard({
    super.key,
    required this.onPressed,
    required this.category,
    required this.onUnlocked,
  });

  @override
  State<GoalCategoryCard> createState() => _GoalCategoryCardState();
}

class _GoalCategoryCardState extends State<GoalCategoryCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;

  bool get isNew => widget.category.isNew && widget.category.isUnlocked;

  void animationListener() {
    if (controller.status == AnimationStatus.completed) {
      widget.onUnlocked();
    }
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && isNew && controller.status == AnimationStatus.dismissed) {
      Future.delayed(300.ms, controller.forward);
    }
  }

  Widget getTitle(SmartGoalCategory category) {
    final image = ClipRRect(
      borderRadius: _borderRadius,
      child: SizedBox(
        height: _itemHeight,
        child: NetworkImageWithCache(url: category.image, imageBoxFit: BoxFit.cover),
      ),
    );

    if (widget.category.isUnlocked && !widget.category.isNew) {
      return image;
    }

    return Stack(
      children: [
        image,
        if (isNew)
          Positioned(
            top: 14,
            left: 15,
            child: CategoryLabel.smartGoalNew(),
          )
              .animate(controller: controller, autoPlay: false)
              .scaleXY(begin: 0, delay: 2000.ms, duration: 600.ms, curve: Curves.easeInOutBack),
        Container(
          width: double.infinity,
          height: _itemHeight,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: AppColors.blueOffRegular.withOpacity(0.7),
          ),
          child: Center(
            child: CircleAvatar(
              backgroundColor: AppColors.blueLightest,
              radius: 24,
              child: LottieAnimation.unlock(
                controller: controller,
                onLoaded: (_) {},
              ),
            ),
          ),
        )
            .animate(controller: controller, autoPlay: false)
            .scaleXY(end: 0, delay: 1500.ms, duration: 600.ms, curve: Curves.easeInOutBack)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: 600.ms,
      vsync: this,
    )..addListener(animationListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return VisibilityDetector(
      key: ValueKey(widget.category.hashCode),
      onVisibilityChanged: onVisibilityChanged,
      child: CustomTappableCard.greenLightest(
        contentPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        enabled: widget.category.isUnlocked,
        borderRadius: _borderRadius,
        onPressed: () => widget.onPressed(widget.category),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitle(widget.category),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText.w400(
                  widget.category.name,
                  style: context.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => isNew;
}
