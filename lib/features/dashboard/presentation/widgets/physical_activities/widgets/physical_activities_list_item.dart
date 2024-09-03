import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class PhysicalActivitiesListItem extends StatelessWidget {
  final PhysicalProgram item;

  const PhysicalActivitiesListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AppIcons.checkmark,
          color: item.maybeMap(
            placeholder: (_) => AppColors.greyMid,
            orElse: () => AppColors.greenMid,
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: CustomText.w400(
            item.map(
              basic: (s) => s.name,
              placeholder: (s) => s.name,
              programInProgress: (s) => '${s.name} (${LocalizedTexts.inProgress.tr()})',
            ),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: item.maybeMap(
                  placeholder: (_) => AppColors.greyMid,
                  orElse: () => AppColors.darkGreen,
                )),
          ),
        ),
      ],
    );
  }
}
