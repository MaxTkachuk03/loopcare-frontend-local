import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class PreparationMaterials extends StatelessWidget {
  const PreparationMaterials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final materials = context.read<TopicsBloc>().state.data.thisWeekTopic?.materials.first.article;

    if (materials == null) return null;

    context.router.push(PreparationMaterialsRoute(content: materials));
  }
}
