import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loopcare_frontend/core/presentation/animations/lottie_animation.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

class GoalCategoryCard extends StatelessWidget {
  final void Function(SmartGoalCategory value) onPressed;
  final bool isNew;

  final SmartGoalCategory category;

  const GoalCategoryCard({super.key, required this.onPressed, required this.category, required this.isNew});

  Widget getTitle(SmartGoalCategory category) {
    return Stack(
      children: [
        SizedBox(
            height: 120, child: NetworkImageWithCache(url: category.image, imageBoxFit: BoxFit.fitHeight)),
        if (isNew) Positioned(top: 14, left: 15, child: CategoryLabel.smartGoalNew()),
        if (isNew)
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColors.blueOffRegular.withOpacity(0.7),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundColor: AppColors.blueLightest,
                radius: 24,
                child: LottieAnimation.unlock(delay: 1000.ms),
              ),
            ),
          )
              .animate(delay: 1000.ms)
              .scaleXY(end: 0, delay: 1500.ms, duration: 600.ms, curve: Curves.easeInOutBack)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        tileColor: AppColors.greenLightest,
        enabled: category.isUnlocked,
        onTap: () => onPressed(category),
        title: getTitle(category),
        subtitle: CustomText.w400(
          category.name,
          style: context.textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
