import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/cards/custom_tappable_card.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';

class GoalsListItem extends StatelessWidget {
  final SmartGoal item;
  final void Function(SmartGoal item, bool isSelected) onItemPressed;
  final bool isSelected;
  final bool disable;
  final String stream;

  const GoalsListItem({
    super.key,
    required this.item,
    required this.onItemPressed,
    required this.isSelected,
    this.disable = false,
    required this.stream,
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
    // Define styles for each stream
    final streamStyles = {
      'psychology': {
        'cardColor': AppColors.petrolLightest,
        'textColor': AppColors.petrolRegular,
        'selectedCardColor': AppColors.petrolRegular,
        'selectedTextColor': AppColors.petrolLightest,
      },
      'nutrition': {
        'cardColor': AppColors.greenLightest,
        'textColor': AppColors.greenRegular,
        'selectedCardColor': AppColors.greenRegular,
        'selectedTextColor': AppColors.greenLightest,
      },
      'physicalActivity': {
        'cardColor': AppColors.yellowLightest,
        'textColor': AppColors.yellowRegular,
        'selectedCardColor': AppColors.yellowRegular,
        'selectedTextColor': AppColors.yellowLightest,
      },
      'community': {
        'cardColor': AppColors.orangeLightest,
        'textColor': AppColors.orangeRegular,
        'selectedCardColor': AppColors.orangeRegular,
        'selectedTextColor': AppColors.orangeLightest,
      },
      'medical': {
        'cardColor': AppColors.coralLightest,
        'textColor': AppColors.coralRegular,
        'selectedCardColor': AppColors.coralRegular,
        'selectedTextColor': AppColors.coralLightest,
      },
    };

    // Get current style based on stream
    final currentStyle = streamStyles[stream] ??
        {
          'cardColor': AppColors.greenLightest,
          'textColor': AppColors.greenRegular,
          'selectedCardColor': AppColors.greenRegular,
          'selectedTextColor': AppColors.greenLightest,
        };

    // Use selected or default styles
    final cardColor = isSelected ? currentStyle['selectedCardColor'] : currentStyle['cardColor'];
    final textColor = isSelected ? currentStyle['selectedTextColor'] : currentStyle['textColor'];

    return CustomTappableCard(
      color: cardColor, // Set dynamic card color
      contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 8.0),
      onPressed: _onItemPressedHandler,
      isSelected: isSelected,
      disable: disable,
      selectedColor: cardColor,
      leading: GoalProgressIndicator(
        currentStep: 0,
        steps: item.requiredCompletionDays,
        isAchievedNotifier: false,
      ),
      trailing: IconButton(
        isSelected: isSelected,
        selectedIcon: AppIcons.lightbulbSelect,
        icon: disable ? AppIcons.lightbulbSelect : AppIcons.lightbulbUnSelect,
        onPressed: () => _onInfoHandler(context),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomText.w400(
          item.shortTitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: textColor, // Set dynamic text color
          ),
        ),
      ),
    );
  }
}
