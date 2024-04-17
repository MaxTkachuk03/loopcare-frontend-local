import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

class GoalsListItem extends StatelessWidget {
  final SmartGoal item;
  final void Function(SmartGoal item, bool isSelected) onItemPressed;
  final bool isSelected;

  const GoalsListItem({super.key, required this.item, required this.onItemPressed, required this.isSelected});

  void _onItemPressedHandler() => onItemPressed(item, isSelected);

  void _onInfoHandler(BuildContext context) =>
      ModalBottomSheet.goalFunFact(context: context, title: item.title, content: item.funFact);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onItemPressedHandler,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckbox.green(value: isSelected),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: context.textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: '${item.shortTitle}: ',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: item.description,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      CustomText.w400(
                        LocalizedTexts.completeCounter.tr(
                          args: [item.requiredCompletionDays.toString(), item.lengthInDays.toString()],
                        ),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              CustomIconButton(
                icon: const Icon(Icons.error_outline_outlined, color: AppColors.blueDarker),
                onPressed: () => _onInfoHandler(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
