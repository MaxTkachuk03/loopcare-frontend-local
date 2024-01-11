import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_countdown.dart';

class SessionWaitingPage extends StatefulWidget {
  // TODO pass session as a prop so we can get rid of check if we have session
  const SessionWaitingPage({super.key});

  @override
  State<SessionWaitingPage> createState() => _SessionWaitingPageState();
}

class _SessionWaitingPageState extends State<SessionWaitingPage> {
  ZoomVideoSdk zoom = ZoomVideoSdk();
  final TapGestureRecognizer _groupRulesTapRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    InitConfig initConfig = InitConfig(domain: ZoomConfig.domain, enableLog: ZoomConfig.enableLog);

    zoom.initSdk(initConfig);

    _groupRulesTapRecognizer.onTap = _onRulesTapHandler;

    context.read<VideoPlayerBloc>().add(const VideoPlayerEvent.getAwsCookies(AwsCookiesType.SESSION));

    final int? sessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId;

    context.read<TopicsBloc>().add(TopicsEvent.getSessionSignature(sessionId!));

    super.initState();
  }

  _onRulesTapHandler() => context.router.pushNamed(AppRoutes.sessionRules);

  @override
  Widget build(BuildContext context) {
    final sessionTopic = context.read<TopicsBloc>().state.data.weekTopicName;

    return CustomScaffold.orange(
      appBar: CustomAppBar.orange(
        title: LocalizedTexts.groupSession.tr(),
        subtitle: sessionTopic,
        leading: CustomFilledIconButton.leadingOrangeLighter(),
      ),
      body: SafeArea(
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
                      const SizedBox(height: 35.0),
                      CustomText.w600(
                        '${LocalizedTexts.hi.tr()} ${context.read<AuthenticationCubit>().state.name},',
                        style: context.textTheme.bodyLarge,
                      ),
                      CustomText.w400(
                        '${LocalizedTexts.sessionGreeting.tr()}:',
                        style: context.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      CustomText.bitter600(
                        sessionTopic,
                        style: context.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16.0),
                      CustomText.w600(
                        LocalizedTexts.goodToKnow.tr(),
                        style: context.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.warningOne.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSize: 21.0,
                      ),
                      const SizedBox(height: 8.0),
                      BulletListItem(
                        bulletSize: 21.0,
                        text: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${LocalizedTexts.warningTwo.tr()} ',
                                style: context.textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: LocalizedTexts.groupRules.tr().toLowerCase(),
                                style: context.textTheme.bodyLarge,
                                recognizer: _groupRulesTapRecognizer,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              const SessionCountdown(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    zoom.cleanup();

    _groupRulesTapRecognizer.dispose();

    super.dispose();
  }
}
