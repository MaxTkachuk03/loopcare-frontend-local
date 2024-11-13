import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_countdown.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const double _bottomSheetHeight = 167.0;

@RoutePage()
class SessionWaitingPage extends StatefulWidget {
  // TODO pass session as a prop so we can get rid of check if we have session
  const SessionWaitingPage({super.key});

  @override
  State<SessionWaitingPage> createState() => _SessionWaitingPageState();
}

class _SessionWaitingPageState extends State<SessionWaitingPage> {
  ZoomVideoSdk zoom = ZoomVideoSdk();

  @override
  void initState() {
    InitConfig initConfig = InitConfig(domain: ZoomConfig.domain, enableLog: ZoomConfig.enableLog);

    zoom.initSdk(initConfig);

    context
        .read<VideoPlayerBloc>()
        .add(const VideoPlayerEvent.getAwsCookies(AwsCookiesType.SESSION));

    final int? sessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId;

    context.read<TopicsBloc>().add(TopicsEvent.getSessionSignature(sessionId!));

    super.initState();
  }

  void _onRulesTapHandler() => context.router.pushNamed(AppRoutes.sessionRules);

  String get topic => context.read<TopicsBloc>().state.data.weekTopicName;

  DateTime get startDate =>
      context.read<TopicsBloc>().state.data.signedGroupSessionStartTime ?? DateTime.now();

  DateTime get endDate =>
      context.read<TopicsBloc>().state.data.signedGroupSessionsEndTime ?? DateTime.now();

  String get image => context.read<TopicsBloc>().state.data.thisWeekTopicsImage;

  @override
  Widget build(BuildContext context) {
    final day = startDate.toDateFormat;
    final startTime = startDate.toTimeFormat;
    final endTime = endDate.toTimeFormat;

    return CustomScaffold.orange(
      appBar: CustomAppBar.orange(
        title: LocalizedTexts.groupSession.tr(),
        subtitle: topic,
        leading: CustomFilledIconButton.leadingOrangeLighter(),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: _bottomSheetHeight,
        color: AppColors.blueDarker,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        child: const SessionCountdown(),
      ),
      body: CustomSafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ScrollableContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 28.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 32.0),
                        decoration: const BoxDecoration(
                          color: AppColors.orangeLightest,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.bitter600(
                              '${LocalizedTexts.hey.tr()} ${getIt<SharedStorageService>().account!.name.capitalizeOnlyFirstLetter()}',
                              style: context.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 18.0),
                            CustomText.w400(
                              // todo: move sign to translation
                              '${LocalizedTexts.sessionGreeting.tr()}:',
                              style: context.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 18.0),
                            Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.blueLighter,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Row(
                                children: [
                                  ClipPath(
                                    clipper: ImageClipper(),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: 135,
                                        height: 180,
                                        child: NetworkImageWithCache(url: image),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 12.0, right: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10.0),
                                          CustomText.w700(
                                            topic,
                                            style: context.textTheme.bodySmall,
                                          ),
                                          const SizedBox(height: 10.0),
                                          CustomText.w400(
                                            LocalizedTexts.dayFromTo.tr(
                                              {
                                                'day': day,
                                                'startTime': startTime,
                                                'endTime': endTime,
                                              },
                                            ),
                                            style: context.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 32.0),
                        decoration: const BoxDecoration(
                          color: AppColors.orangeLightest,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.w600(
                              LocalizedTexts.goodToKnow.tr(),
                              style: context.textTheme.bodyLarge,
                            ),
                            BulletListItem(
                              bulletSize: 21.0,
                              text: CustomText.w400(
                                LocalizedTexts.warningOne.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            BulletListItem(
                              bulletSize: 21.0,
                              text: CustomText.w400(
                                LocalizedTexts.warningTwo.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(height: 18.0),
                            CustomOutlinedButton.blueFullWidth(
                              label: LocalizedTexts.readTheGroupRules.tr(),
                              onPressed: _onRulesTapHandler,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: _bottomSheetHeight),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    zoom.cleanup();

    super.dispose();
  }
}
