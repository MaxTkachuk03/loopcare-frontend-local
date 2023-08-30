// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class PreparationMaterials extends StatelessWidget {
  // final GroupSession signedGroupSessions;

  const PreparationMaterials({
    Key? key,
    // required this.signedGroupSessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1,
            color: AppColors.yellowLight,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu_book),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizedTexts.prepareForSession.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                ).tr(),
                Text(
                  LocalizedTexts.prepareTakes.tr(
                    namedArgs: {'times': '10 min'},
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const ImageIcon(
              AppIcons.arrow,
              color: AppColors.greyLabel,
            ),
          ],
        ),
      ),
    );
  }

  _onMoreInfoPressed(BuildContext context) {
    ModalBottomSheet.sessionMoreInfoDialog(context: context);
  }
}
