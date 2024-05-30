import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';

class GoalsListItem extends StatelessWidget {
  final SmartGoal item;
  final void Function(SmartGoal item, bool isSelected) onItemPressed;
  final bool isSelected;

  const GoalsListItem({
    super.key,
    required this.item,
    required this.onItemPressed,
    required this.isSelected,
  });

  void _onItemPressedHandler() => onItemPressed(item, isSelected);

  void _onInfoHandler(BuildContext context) => ModalBottomSheet.goalFunFact(
        context: context,
        title: item.shortTitle,
        subtitle: item.title,
        task: item.description,
        content: item.funFact,
    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 12.0, right: 4.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          fixedSize: const Size.fromHeight(68.0),
          backgroundColor: isSelected ? AppColors.greenRegular : AppColors.greenLightest,
          surfaceTintColor: AppColors.transparent,
          elevation: isSelected ? 0 : 4,
        ),
        icon: GoalProgressIndicator(
          currentStep: 0,
          steps: item.requiredCompletionDays,
          isAchievedNotifier: false,
        ),
        onPressed: _onItemPressedHandler,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CustomText.w400(
                  item.shortTitle,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ),
            IconButton(
              isSelected: isSelected,
              selectedIcon: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: SizedBox.square(
                  dimension: 24,
                  child: Icon(
                    Icons.emoji_objects_rounded,
                    color: AppColors.greenRegular,
                    size: 16,
                  ),
                ),
              ),
              icon: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greenRegular,
                ),
                child: SizedBox.square(
                  dimension: 24,
                  child: Icon(
                    Icons.emoji_objects_rounded,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
              onPressed: () => _onInfoHandler(context),
            ),
          ],
        ),
      ),
    );
  }
}
