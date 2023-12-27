import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class AssignmentListItem extends StatelessWidget {
  final LessonQuestion item;
  final Function(int lessonId) onBtnPressed;
  final bool onDashboard;
  final bool isOpen;
  final bool isComplete;

  const AssignmentListItem({
    super.key,
    required this.item,
    required this.onBtnPressed,
    required this.onDashboard,
    required this.isOpen,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onBtnPressed(item.lessonId),
        child: Ink(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                child: ImageIcon(
                  AppIcons.iconCheckmark,
                  color: isComplete ? AppColors.greenMid : AppColors.greyMid,
                  size: 14,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.w600(item.title, style: context.textTheme.bodySmall),
                    if (isComplete)
                      CustomText.w400(
                        LocalizedTexts.completedOn.tr(
                          namedArgs: {'date': item.completedAt?.dayWithMonthWithoutLeadingZero ?? ''},
                        ),
                        style: context.textTheme.bodySmall,
                      ),
                    if (!isComplete && isOpen)
                      CustomText.w400(
                        LocalizedTexts.completeBefore.tr(
                          namedArgs: {'date': item.openedAt?.plusWeekShortVersion ?? ''},
                        ),
                        style: context.textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 14.0),
              const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
