import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class PreparationMaterials extends StatelessWidget {
  const PreparationMaterials({super.key});

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
            color: AppColors.blueLighter,
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
                CustomText.w700(
                  LocalizedTexts.prepareForSession.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                CustomText.w400(
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
    final userId = context.read<AuthenticationCubit>().state.id;
    final sessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId ?? 0;

    context
        .read<AnalyticsBloc>()
        .add(AnalyticsEvent.sendAnalytics(AnalyticsEvents.openedSessionPreparationMaterials, {
          "timestamp": DateTime.now().toIso8601String(),
        }));

    AnalyticsEventService.instance.openedSessionPreparationMaterialsEvent(userId, sessionId);

    context.router.pushNamed(AppRoutes.preparationMaterials);
  }
}
