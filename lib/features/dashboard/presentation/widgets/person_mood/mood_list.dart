import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/utils.dart';

class MoodList extends StatelessWidget {
  final List<Mood> list;

  final void Function(Mood item) onPressItem;

  const MoodList({super.key, required this.list, required this.onPressItem});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return CustomText.w400(
        LocalizedTexts.noMoodRecords.tr(),
        style: context.textTheme.bodySmall,
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
          onTap: () => onPressItem(item),
          child: Row(
            children: [
              MoodUtils.getMoodIconByValue(item.scale),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomText.w400twoLineItalic(
                    text,
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ),
              const ImageIcon(AppIcons.arrow, color: AppColors.blueDarker),
            ],
          ),
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 10.0),
    );
  }
}
