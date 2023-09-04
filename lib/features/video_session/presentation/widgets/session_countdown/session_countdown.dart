import 'dart:io';
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_timer.dart';
import 'package:permission_handler/permission_handler.dart';

part 'session_countdown.freezed.dart';

@freezed
class SessionTimerMode with _$SessionTimerMode {
  const factory SessionTimerMode.sessionStarted() = SessionStarted;

  const factory SessionTimerMode.sessionNotStarted() = SessionNotStarted;

  const factory SessionTimerMode.sessionStartedMoreThanFifteenMinutesAgo() =
      SessionStartedMoreThanFifteenMinutesAgo;

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
    _updateSessionState();

    super.initState();
  }

  void _updateSessionState() {
    final signedSession = context.read<TopicsBloc>().state.data.signedGroupSession;

    if (signedSession == null) {
      _sessionTimerMode = const SessionTimerMode.sessionNotStarted();
    } else if (!signedSession.isStartedLessThanFifteenMinutesAgo) {
      _sessionTimerMode = const SessionTimerMode.sessionStartedMoreThanFifteenMinutesAgo();
    } else if (signedSession.isSessionAlreadyStarted) {
      _sessionTimerMode = const SessionTimerMode.sessionStarted();
    } else {
      _sessionTimerMode = const SessionTimerMode.sessionNotStarted();
    }

    setState(() {});
  }

  String get text => _sessionTimerMode.map(
        sessionStarted: (_) => LocalizedTexts.sessionStartedMessage,
        sessionNotStarted: (_) => LocalizedTexts.sessionWillStartIn,
        sessionError: (_) => LocalizedTexts.signatureErrorMessage,
        sessionStartedMoreThanFifteenMinutesAgo: (_) => LocalizedTexts.sessionStartsMoreThanFifteenMinutesAgo,
      );

  TextStyle get textStyles => _sessionTimerMode.map(
        sessionStarted: (_) => const TextStyle(
          color: AppColors.darkGreen,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        sessionNotStarted: (_) => const TextStyle(
          color: AppColors.darkGreen,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        sessionError: (_) => const TextStyle(
          color: AppColors.red,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        sessionStartedMoreThanFifteenMinutesAgo: (_) => const TextStyle(
          color: AppColors.red,
          fontSize: 18,
          fontWeight: FontWeight.w600,
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
    // final signedSession = context.read<TopicsBloc>().state.data.signedGroupSession;

    // if (signedSession == null) return;
    //
    // if (!signedSession.isStartedLessThanFifteenMinutesAgo) {
    //   setState(() {
    //     _sessionTimerMode = const SessionTimerMode.sessionStartedMoreThanFifteenMinutesAgo();
    //   });
    //
    //   return;
    // }
    //
    // final hasPermissions = await requestFilePermissions();
    // if (!hasPermissions) {
    //   print('not all permissions are provided');
    //   return;
    // }

    context.router.pushNamed(AppRoutes.sessionCall);
  }

  _onTimerEndsHandler() {
    setState(() {
      _sessionTimerMode = const SessionTimerMode.sessionStarted();
    });
  }

  void _onErrorListener(BuildContext context, TopicsState state) {
    showAppSnackBar(
      context: context,
      text: LocalizedTexts.somethingWentWrong.tr(),
      background: AppColors.red,
      textColor: Colors.white,
    );

    setState(() {
      _sessionTimerMode = const SessionTimerMode.sessionError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopicsBloc, TopicsState>(
      listenWhen: (prev, cur) => cur is TopicsStateError,
      listener: _onErrorListener,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(width: 1, color: AppColors.yellowLight)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text,
                style: textStyles,
                textAlign: TextAlign.center,
              ).tr(),
            ),
            const SizedBox(height: 16.0),
            _sessionTimerMode.map(
              sessionStarted: (_) => ElevatedButton(
                onPressed: _onEnterSessionHandler,
                child: const Text(
                  LocalizedTexts.enterSession,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
              ),
              sessionNotStarted: (_) => SessionTimer(
                value: context.read<TopicsBloc>().state.data.timeLeftToSessionStart.inSeconds,
                onTimerEnds: _onTimerEndsHandler,
              ),
              sessionError: (_) => const SizedBox.shrink(),
              sessionStartedMoreThanFifteenMinutesAgo: (_) => const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
