import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_timer.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:permission_handler/permission_handler.dart';

part 'session_countdown.freezed.dart';

@freezed
class SessionTimerMode with _$SessionTimerMode {
  const factory SessionTimerMode.sessionStarted() = SessionStarted;

  const factory SessionTimerMode.sessionNotStarted() = SessionNotStarted;

  const factory SessionTimerMode.sessionEnded() = SessionEnded;

  const factory SessionTimerMode.sessionError() = SessionError;
}

class SessionCountdown extends StatefulWidget {
  const SessionCountdown({super.key});

  @override
  State<SessionCountdown> createState() => _SessionCountdownState();
}

class _SessionCountdownState extends State<SessionCountdown> {
  late SessionTimerMode _sessionTimerMode;

  @override
  void initState() {
    requestFilePermissions();
    _updateSessionState();

    super.initState();
  }

  void _updateSessionState() {
    final signedSession = context.read<TopicsBloc>().state.data.signedGroupSession;

    if (signedSession == null) {
      _sessionTimerMode = const SessionTimerMode.sessionNotStarted();
    } else if (signedSession.isSessionAlreadyStarted) {
      _sessionTimerMode = const SessionTimerMode.sessionStarted();
    } else if (signedSession.isSessionEnded) {
      _sessionTimerMode = const SessionTimerMode.sessionEnded();
    } else {
      _sessionTimerMode = const SessionTimerMode.sessionNotStarted();
    }

    setState(() {});
  }

  String get text => _sessionTimerMode.map(
        sessionStarted: (_) => LocalizedTexts.sessionStartedMessage,
        sessionNotStarted: (_) => LocalizedTexts.sessionWillStartIn,
        sessionError: (_) => LocalizedTexts.signatureErrorMessage,
        sessionEnded: (_) => LocalizedTexts.sessionAlreadyEnded,
      );

  TextStyle get textStyles => _sessionTimerMode.map(
        sessionStarted: (_) => const TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        sessionNotStarted: (_) => const TextStyle(
          color: AppColors.white,
          fontSize: 18,
        ),
        sessionError: (_) => const TextStyle(
          color: AppColors.red,
          fontSize: 18,
        ),
        sessionEnded: (_) => const TextStyle(
          color: AppColors.red,
          fontSize: 18,
        ),
      );

  Future<bool> requestFilePermissions() async {
    if (!Platform.isAndroid && !Platform.isIOS) return false;

    bool blocked = false;
    List<Permission> notGranted = [];

    List<Permission> permissions = ZoomConfig.permissionsList;

    Map<Permission, PermissionStatus>? statuses = await permissions.request();

    statuses.forEach((key, status) {
      if (status.isDenied || status.isPermanentlyDenied) {
        blocked = true;
      } else if (!status.isGranted) {
        notGranted.add(key);
      }
    });

    if (notGranted.isNotEmpty) {
      notGranted.request();
    }

    if (blocked) {
      return await openAppSettings();
    }

    return true;
  }

  void _onEnterSessionHandler() async {
    final signedSession = context.read<TopicsBloc>().state.data.signedGroupSession;

    if (signedSession == null) return;

    final hasPermissions = await requestFilePermissions();
    if (!hasPermissions) return;

    if (mounted) {
      context.router.pushNamed(AppRoutes.sessionCall);
    }
  }

  _onTimerEndsHandler() {
    setState(() {
      _sessionTimerMode = const SessionTimerMode.sessionStarted();
    });
  }

  void _onErrorListener(BuildContext context, TopicsState state) {
    context.showError(content: CustomText(LocalizedTexts.errorSomethingWentWrong.tr()));
    setState(() {
      _sessionTimerMode = const SessionTimerMode.sessionError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopicsBloc, TopicsState>(
      listenWhen: (prev, cur) => cur is TopicsStateError,
      listener: _onErrorListener,
      child: Column(
        children: [
          CustomText.w400(
            text.tr(),
            style: textStyles,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18.0),
          _sessionTimerMode.map(
            sessionStarted: (_) => CustomElevatedButton.orangeFullWidth(
              onPressed: _onEnterSessionHandler,
              label: LocalizedTexts.joinSession.tr(),
            ),
            sessionNotStarted: (_) => FutureBuilder<Duration>(
              future: context.read<TopicsBloc>().state.data.timeLeftToSessionStart,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (snapshot.hasData && data != null) {
                  return SessionTimer(value: data.inSeconds, onTimerEnds: _onTimerEndsHandler);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            sessionError: (_) => const SizedBox.shrink(),
            sessionEnded: (_) => const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
