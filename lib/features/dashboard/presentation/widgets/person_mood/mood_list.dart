import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class MoodList extends StatelessWidget {
  final List<Mood> list;
  final bool isEditable;

  final void Function(Mood item) onPressItem;

  const MoodList(
      {super.key, required this.list, required this.onPressItem, required this.isEditable});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return CustomText.w400(
        LocalizedTexts.noMoodRecords.tr(),
        style: context.textTheme.bodySmall
            ?.copyWith(color: isEditable ? AppColors.blueDarker : AppColors.greyLabel),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        final item = list[i];
        final text =
            '${item.dashboardTime} ${item.note.isEmpty ? item.location.map((e) => e).join(', ') : item.note}';

        return GestureDetector(
          onTap: isEditable ? () => onPressItem(item) : null,
          child: Stack(
            children: [
              Row(
                children: [
                  MoodUtils.getMoodIconByValue(item.scale),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomText.w400twoLineItalic(text, style: context.textTheme.bodySmall),
                    ),
                  ),
                  const ImageIcon(AppIcons.arrow, color: AppColors.blueDarker),
                ],
              ),
              if (!isEditable)
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(color: AppColors.white.withOpacity(0.5)),
                ),
            ],
          ),
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 10.0),
    );
  }
}
