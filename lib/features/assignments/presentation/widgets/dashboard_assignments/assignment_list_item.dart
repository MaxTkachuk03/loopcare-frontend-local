import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class AssignmentListItem extends StatelessWidget {
  final LessonQuestion item;
  final Function(int lessonId) onBtnPressed;
  final bool onDashboard;
  final bool isDone;

  const AssignmentListItem({
    super.key,
    required this.item,
    required this.onBtnPressed,
    required this.onDashboard,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onBtnPressed(item.lessonId),
        child: Ink(
          color: onDashboard ? AppColors.white : AppColors.bgGreen,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                child: ImageIcon(
                  AppIcons.iconCheckmark,
                  color: isDone ? AppColors.greenMid : AppColors.greyMid,
                  size: 14,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (isDone)
                      Text(
                        LocalizedTexts.completedOn,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: onDashboard ? AppColors.greyLabel : AppColors.darkGreen,
                            ),
                      ).tr(
                        namedArgs: {'date': item.answeredAt?.dayWithMonthWithoutLeadingZero ?? ''},
                      ),
                    if (!isDone)
                      Text(
                        LocalizedTexts.completeBefore,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: onDashboard ? AppColors.greyLabel : AppColors.darkGreen,
                            ),
                      ).tr(
                        namedArgs: {'date': item.openedAt?.plusWeekShortVersion ?? ''},
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
