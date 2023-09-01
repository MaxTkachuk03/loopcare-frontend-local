// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class PreparationMaterials extends StatelessWidget {
  // final GroupSession signedGroupSessions;

  const PreparationMaterials({
    Key? key,
    // required this.signedGroupSessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('12345');
    return InkWell(
      onTap: () => _onMoreInfoPressed(context),
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
                  LocalizedTexts.prepareForSession,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                ).tr(),
                BlocBuilder<TopicsBloc, TopicsState>(
                  builder: (context, state) {
                    final duration = state.data.topics[DateTime.now().weekNumber]?.duration ?? 0;

                    return Text(
                      LocalizedTexts.prepareTakes.tr(
                        namedArgs: {'times': '${Duration(seconds: duration).inMinutes} min'},
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
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
    ModalBottomSheet.sessionsDialog(context: context);
  }
}
