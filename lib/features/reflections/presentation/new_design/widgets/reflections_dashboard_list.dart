import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/practice_lesson_list/practice_lesson_card_status_types.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

import '../../../../../core/presentation/icon_images/app_icons.dart';
import '../../../../../core/presentation/themes/themes.dart';

class ReflectionsDashboardListItem extends StatelessWidget {
  final Reflection item;
  final PracticeLessonCardStatusTypes itemStatus;
  final Function(BuildContext, Reflection, bool) onItemPressedHandler;

  const ReflectionsDashboardListItem({
    super.key,
    required this.item,
    required this.itemStatus,
    required this.onItemPressedHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: itemStatus == PracticeLessonCardStatusTypes.locked
            ? null
            : () => onItemPressedHandler(context, item, true),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemStatus == PracticeLessonCardStatusTypes.completed
                        ? const Image(
                            image: AppIcons.practiceLessonCompleted,
                            width: 20,
                            height: 20,
                          )
                        : const SizedBox(width: 20.0),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: CustomText.w600(item.title, style: context.textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              const Icon(Icons.chevron_right_rounded, color: AppColors.blueDarker, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
