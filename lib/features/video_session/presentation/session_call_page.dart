import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/call_controls.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/error_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/prompts_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/report_issue.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_app_bar.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_video_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/settings_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/users_grid.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SessionCallPage extends StatefulWidget {
  const SessionCallPage({super.key});

  @override
  State<SessionCallPage> createState() => _SessionCallPageState();
}

class _SessionCallPageState extends State<SessionCallPage> with WidgetsBindingObserver {
  ZoomVideoSdk zoom = ZoomVideoSdk();
  ZoomVideoSdkEventListener eventListener = ZoomVideoSdkEventListener();

  int get userId => getIt<SharedStorageService>().account!.id;

  late final dynamic _sessionJoinListener;
  late final dynamic _userJoinListener;
  late final dynamic _userLeaveListener;
  late final dynamic _sessionLeaveListener;
  late final dynamic _userAudioStatusChangedListener;
  late final dynamic _userActiveAudioChangedListener;
  late final dynamic _userVideoStatusChangedListener;
  late final dynamic _cloudRecordingStatusListener;
  late final dynamic _networkStatusChangeListener;
  late final dynamic _requireSystemPermission;
  late final dynamic _eventErrorListener;

  List<ZoomVideoSdkUser> _sessionParticipants = [];
  List<String> _talkingUsers = [];
  List<String> _usersWithCameraOff = [];
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isVideoOn = false;
  bool isInSession = false;
  bool _isCloudRecordingActive = false;

  String _error = '';
  Timer? _timer;
  Timer? _inactivityTimer;

  bool _isVideoPlaying = false;

  @override
  void initState() {
    context.read<SessionCallBloc>().add(const SessionCallEvent.resetTimerValue());
    WidgetsBinding.instance.addObserver(this);

    WakelockPlus.enable();

    _initSessionListeners();
    _joinSession();

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      _setInactiveUserState();
    }
    if (state == AppLifecycleState.paused) {
      _setInactiveUserState();
      _setInactivityTimer();
    } else if (state == AppLifecycleState.resumed) {
      _setActiveUserState(_isVideoPlaying);
      _inactivityTimer?.cancel();
    }
  }

  _setInactiveUserState() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

    final userMuteState = await zoom.audioHelper.muteAudio(mySelf!.userId);
    final userVideoOffState = await zoom.videoHelper.stopVideo();

    _showToggleMicPopup(status: userMuteState, isOn: false);

    MixpanelEventService.instance.track(
      AppMixpanelEvents.sessionInactiveState,
      {
        "userId": userId,
        "userName": mySelf.userName,
        "userMuteState": userMuteState,
        "userVideoOffState": userVideoOffState,
        "userLocalTime": DateTime.now().toLocal().toIso8601String(),
      },
    );
  }

  _setActiveUserState(bool isVideoPlaying) async {
    if (isVideoPlaying) return;

    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

    final userMuteState = await zoom.audioHelper.unMuteAudio(mySelf!.userId);
    final userVideoOffState = await zoom.videoHelper.startVideo();

    _showToggleMicPopup(status: userMuteState, isOn: true);

    MixpanelEventService.instance.track(
      AppMixpanelEvents.sessionActiveState,
      {
        "userId": userId,
        "userName": mySelf.userName,
        "userMuteState": userMuteState,
        "userVideoOffState": userVideoOffState,
        "userLocalTime": DateTime.now().toLocal().toIso8601String(),
      },
    );
  }

  void _showToggleMicPopup({String status = '', bool isOn = false}) {
    final micState = isOn ? LocalizedTexts.on : LocalizedTexts.off;

    status == Errors.Success
        ? context.showSuccessBar(
            content: Text(
              LocalizedTexts.micState.tr(namedArgs: {"micState": micState}),
            ),
          )
        : context.showError(content: Text(LocalizedTexts.somethingWentWrong.tr()));
  }

  void _setInactivityTimer() {
    if (Platform.isIOS) return;

    _inactivityTimer?.cancel();

    _inactivityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= 60) {
        _leaveSessionHandler();
        timer.cancel();
      }
    });
  }

  void _joinSession() {
    Future<void>.microtask(() async {
      final String? sessionPassword = context.read<TopicsBloc>().state.data.signedGroupSessionPassword;
      final String? sessionKey = context.read<TopicsBloc>().state.data.signedGroupSessionKey;

      final String token = context.read<TopicsBloc>().state.data.signedSessionSignature;

      log('session token = $token', name: 'zoomSessionLog');

      final account = getIt<SharedStorageService>().account;
      final String userName = account!.nickname ?? account.name;

      JoinSessionConfig joinSession = JoinSessionConfig(
        sessionName: sessionKey,
        sessionPassword: sessionPassword ?? ZoomConfig.defaultSessionPwd,
        token: token,
        userName: userName,
        audioOptions: ZoomConfig.sdkAudioOptions,
        videoOptions: ZoomConfig.sdkVideoOptions,
        sessionIdleTimeoutMins: ZoomConfig.sessionIdleTimeoutMins,
      );

      try {
        await zoom.joinSession(joinSession);
      } catch (e) {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.joinSessionFail,
          {
            "userId": userId,
            "userName": joinSession.userName,
            "sessionToken": joinSession.token,
            "error": e.toString(),
          },
        );
        log('Error while join session $e', name: 'zoomSessionLog');
        const AlertDialog(title: Text("Error"), content: Text("Failed to join the session"));
      }
    });
  }

  void _reconnectToTheSession() {
    _timer?.cancel();
    Timer(const Duration(milliseconds: 500), () async {
      await zoom.leaveSession(false);
      _joinSession();
    });
  }

  void _startTimer() async {
    if (_timer != null) _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final Duration passedTime = await context.read<TopicsBloc>().state.data.timePassedSinceSessionStart;

      if (mounted) {
        context.read<SessionCallBloc>().add(SessionCallEvent.setTimerValue(passedTime.inSeconds));
      }
    });
  }

  _initSessionListeners() {
    eventListener.addEventListener();

    var emitter = eventListener.eventEmitter;

    _sessionJoinListener = emitter.on(EventType.onSessionJoin, (sessionUser) async {
      isInSession = true;

      AnalyticsEventService.instance.logEvent(FirebaseEvents.userEntersSession);

      _startTimer();

      log('_sessionJoinListener', name: 'zoomSessionLog');

      ZoomVideoSdkUser mySelf = ZoomVideoSdkUser.fromJson(jsonDecode(sessionUser.toString()));
      List<ZoomVideoSdkUser>? remoteUsers = await zoom.session.getRemoteUsers();
      var muted = await mySelf.audioStatus?.isMuted();
      var videoOn = await mySelf.videoStatus?.isOn();
      var speakerOn = await zoom.audioHelper.getSpeakerStatus();

      if (!_isCloudRecordingActive) {
        await zoom.recordingHelper.startCloudRecording();
      }

      await zoom.audioHelper.setSpeaker(true);

      _sessionParticipants = [mySelf, ...?remoteUsers];
      isMuted = muted!;
      isSpeakerOn = speakerOn;
      isVideoOn = videoOn!;

      if (mounted) {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.onSessionJoin,
          {
            "userId": userId,
            "isMuted": muted,
            "videoOn": videoOn,
            "speakerOn": speakerOn,
            "currentLocalTime": DateTime.now().toLocal().toIso8601String(),
            "sessionTime": context.read<SessionCallBloc>().state.data.sessionTime,
          },
        );
      }

      setState(() {});
    });

    _sessionLeaveListener = emitter.on(EventType.onSessionLeave, (data) async {
      isInSession = false;

      if (_isCloudRecordingActive) {
        await zoom.recordingHelper.stopCloudRecording();
      }

      log('_sessionLeaveListener $data', name: 'zoomSessionLog');

      _timer?.cancel();

      _sessionParticipants = <ZoomVideoSdkUser>[];

      setState(() {});
    });

    _userJoinListener = emitter.on(EventType.onUserJoin, (Map data) async {
      log('_userJoinListener $data', name: 'zoomSessionLog');

      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      var userListJson = jsonDecode(data['remoteUsers']) as List;

      setState(() {
        _sessionParticipants = [
          mySelf!,
          ...userListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
        ];
      });
    });

    _userLeaveListener = emitter.on(EventType.onUserLeave, (Map data) async {
      log('_userLeaveListener $data', name: 'zoomSessionLog');

      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      var remoteUserListJson = jsonDecode(data['remoteUsers']) as List;

      if (context.mounted) {
        setState(() {
          _sessionParticipants = [
            mySelf!,
            ...remoteUserListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)).toList()
          ];
        });
      }
    });

    _userActiveAudioChangedListener = emitter.on(EventType.onUserActiveAudioChanged, (Map data) async {
      // Gets list of user who are speaking at the moment
      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      _talkingUsers = userList.map((u) => u.userId).toList();

      setState(() {});
    });

    _userAudioStatusChangedListener = emitter.on(EventType.onUserAudioStatusChanged, (Map data) async {
      log('_userAudioStatusChangedListener $data', name: 'zoomSessionLog');

      final ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      for (var user in userList) {
        if (user.userId != mySelf?.userId) return;
        mySelf?.audioStatus?.isMuted().then((muted) => isMuted = muted);
      }

      setState(() {});
    });

    _userVideoStatusChangedListener = emitter.on(EventType.onUserVideoStatusChanged, (Map data) async {
      log('_userVideoStatusChangedListener $data', name: 'zoomSessionLog');

      final ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      List<String> usersWithCameraOff = [];

      for (var user in userList) {
        user.videoStatus?.isOn().then((value) {
          if (!value) usersWithCameraOff.add(user.userId);
          if (user.userId == mySelf?.userId) isVideoOn = value;
        });
      }

      _usersWithCameraOff = usersWithCameraOff;

      setState(() {});
    });

    _cloudRecordingStatusListener = emitter.on(EventType.onCloudRecordingStatus, (Map data) async {
      _isCloudRecordingActive = data['status'] == 'ZoomVideoSDKRecordingStatus_Start';
      setState(() {});

      log('_cloudRecordingStatusListener - ${data['status']}', name: 'zoomSessionLog');
    });

    _networkStatusChangeListener = emitter.on(EventType.onUserVideoNetworkStatusChanged, (Map data) async {
      ZoomVideoSdkUser? networkUser = ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));

      log('_networkStatusChangeListener - $networkUser ${data['status']}', name: 'zoomSessionLog');

      if (data['status'] == NetworkStatus.Bad) {
        context.showError(content: Text(LocalizedTexts.badConnectionMessage.tr()));
      }
    });

    _requireSystemPermission = emitter.on(EventType.onRequireSystemPermission, (Map data) async {
      log('_requireSystemPermission - $data', name: 'zoomSessionLog');
      //FIXME refactor this listener
      // ZoomVideoSdkUser? changedUser = ZoomVideoSdkUser.fromJson(jsonDecode(data['changedUser']));

      var permissionType = data['permissionType'];
      switch (permissionType) {
        case SystemPermissionType.Camera:
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Can't Access Camera"),
              content: const Text("please turn on the toggle in system settings to grant permission"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          break;
        case SystemPermissionType.Microphone:
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Can't Access Microphone"),
              content: const Text("please turn on the toggle in system settings to grant permission"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          break;
      }
    });

    _eventErrorListener = emitter.on(EventType.onError, (Map data) async {
      String errorType = data['errorType'];

      log('_eventErrorListener called with $errorType', name: 'zoomSessionLog');

      MixpanelEventService.instance.track(
        AppMixpanelEvents.sessionFail,
        {
          "userId": userId,
          "errorType": errorType,
        },
      );

      if (_error == errorType) return;

      setState(() {
        _error = errorType;
      });

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          errorText: errorType,
          onErrorHandler: () {
            context.router.pop();
            if (!isInSession) _onErrorHandler(errorType);
          },
        ),
      );
    });
  }

  Future _enableLandscapeOrientation() async {
    SystemService.hideSystemOverlays();
    SystemService.allowBothOrientations();
  }

  Future _enablePortraitOrientation() async {
    SystemService.showSystemOverlays();
    SystemService.allowOnlyPortraitOrientation();
  }

  void _onErrorHandler(errorType) async {
    if (errorType == Errors.SessionAlreadyInProgress ||
        errorType == Errors.SessionJoinFailed ||
        errorType == Errors.SessionDisconncting) {
      _reconnectToTheSession();
    }
  }

  List<ZoomVideoSdkUser> _getSessionChangedUsers(Map data) {
    final List userListJson = jsonDecode(data['changedUsers']) as List;

    return userListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)).toList();
  }

  _endSession() async {
    ModalBottomSheet.leaveSessionCall(
      context: context,
      onLeavePressed: _leaveSessionHandler,
      onStayPressed: context.router.pop,
    );
  }

  _leaveSessionHandler() async {
    AnalyticsEventService.instance.logEvent(FirebaseEvents.userLeaveSession);

    await zoom.leaveSession(false);
    if (context.mounted) {
      context.router.pop();
    }
  }

  _forceEndSession() async {
    await zoom.leaveSession(true);

    if (context.mounted) {
      context.router.popUntilRouteWithPath(AppRoutes.home);
      context.showSuccessBar(content: Text(LocalizedTexts.sessionEndDialogText.tr()));
    }
  }

  void onPressAudio() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
    if (mySelf == null) return;

    final audioStatus = mySelf.audioStatus;

    if (audioStatus == null) return;

    final bool muted = await audioStatus.isMuted();

    if (muted) {
      await zoom.audioHelper.unMuteAudio(mySelf.userId);
    } else {
      await zoom.audioHelper.muteAudio(mySelf.userId);
    }
  }

  void onPressVideo() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
    if (mySelf == null) return;

    final videoStatus = mySelf.videoStatus;

    if (videoStatus == null) return;

    final bool videoOn = await videoStatus.isOn();

    if (videoOn) {
      await zoom.videoHelper.stopVideo();
    } else {
      await zoom.videoHelper.startVideo();
    }
  }

  void onToggleSpeaker() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

    if (mySelf == null) return;

    if (!await zoom.audioHelper.canSwitchSpeaker()) _showNotSupportSnack();

    await zoom.audioHelper.setSpeaker(!isSpeakerOn);

    final isOn = await zoom.audioHelper.getSpeakerStatus();

    setState(() {
      isSpeakerOn = isOn;
    });
  }

  void _showNotSupportSnack() => context.showError(content: Text(LocalizedTexts.toggleSpeakerError.tr()));

  void onSettingsHandler() {
    showDialog(
      context: context,
      builder: (context) => SettingsDialog(onToggleSpeaker: onToggleSpeaker, isSpeakerOn: isSpeakerOn),
    );
  }

  bool get userJoinedToSession => isInSession && _sessionParticipants.isNotEmpty;

  void _onVideoPlayingHandler(bool isVideoPlaying) async {
    if (isVideoPlaying) {
      _enableLandscapeOrientation();
      _setInactiveUserState();
    } else {
      _enablePortraitOrientation();
      await zoom.videoHelper.startVideo();
    }

    setState(() {
      _isVideoPlaying = isVideoPlaying;
    });
  }

  Future<void> _onReportIssueHandler() async {
    final signedSessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId;
    if (signedSessionId == null) return;

    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    final Duration timePassed = await context.read<TopicsBloc>().state.data.timePassedSinceSessionStart;

    final sessionReport = GroupSessionReport(
      id: signedSessionId,
      time: formatSecondsToTimeString(timePassed.inSeconds),
    );

    if (mounted) {
      ModalBottomSheet.reportAbuse(context: context, groupSession: sessionReport);
    }

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.groupSessionReportedIssue,
      parameters: {
        CustomDefinitions.sessionId: signedSessionId,
        CustomDefinitions.timePassed: formatSecondsToTimeString(timePassed.inSeconds),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
      final hideAppBar = _isVideoPlaying && orientation == Orientation.landscape;

      return Scaffold(
        backgroundColor: AppColors.orangeOffRegular,
        appBar: hideAppBar
            ? null
            : SessionAppBar(
                sessionName: context.read<TopicsBloc>().state.data.weekTopicName,
                onEndSessionHandler: _endSession,
              ),
        body: Container(
          color: AppColors.black,
          child: CustomSafeArea(
            bottom: !hideAppBar,
            child: Stack(
              children: [
                if (!_isVideoPlaying)
                  if (userJoinedToSession)
                    Container(
                      color: AppColors.ff313030,
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          UsersGrid(
                            users: _sessionParticipants,
                            talkingUsers: _talkingUsers,
                            usersWithCameraOff: _usersWithCameraOff,
                          ),
                          SliverFillRemaining(
                            child: BlocBuilder<SessionCallBloc, SessionCallState>(
                              builder: (context, state) {
                                final textEvents = context.read<TopicsBloc>().state.data.textEvents;

                                final text = textEvents
                                        .lastWhereOrNull((e) => state.data.sessionTime >= e.timestamp)
                                        ?.text ??
                                    '';

                                return PromptsContainer(text: text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                if (!userJoinedToSession) const Loader(),
                if (userJoinedToSession)
                  BlocBuilder<SessionCallBloc, SessionCallState>(
                    builder: (context, state) {
                      final currentSession = context.read<TopicsBloc>().state.data.signedGroupSession;

                      if (currentSession != null && currentSession.isSessionEnded) {
                        _forceEndSession();
                      }

                      return state.maybeMap(
                        updateSessionTime: (s) {
                          return SessionVideoContainer(
                            sessionTimer: s.data.sessionTime,
                            onVideoPlayingListener: _onVideoPlayingHandler,
                            orientation: orientation,
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: !_isVideoPlaying && userJoinedToSession
            ? Container(
                color: AppColors.white,
                child: SizedBox(
                  height: Platform.isIOS ? 160 : 100,
                  child: Column(
                    children: [
                      if (Platform.isIOS) ReportIssue(onReportIssueHandler: _onReportIssueHandler),
                      Expanded(
                        child: CallControls(
                          onMuteHandler: onPressAudio,
                          onStopVideoHandler: onPressVideo,
                          isMuted: isMuted,
                          isCameraOn: isVideoOn,
                          onSettingsHandler: onSettingsHandler,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    WakelockPlus.disable();

    _enablePortraitOrientation();

    zoom.leaveSession(false);

    eventListener.eventEmitter.listeners.map((e) => e.cancel());

    eventListener.eventEmitter.removeEventListener(_sessionJoinListener);
    eventListener.eventEmitter.removeEventListener(_userJoinListener);
    eventListener.eventEmitter.removeEventListener(_userLeaveListener);
    eventListener.eventEmitter.removeEventListener(_sessionLeaveListener);
    eventListener.eventEmitter.removeEventListener(_userAudioStatusChangedListener);
    eventListener.eventEmitter.removeEventListener(_userActiveAudioChangedListener);
    eventListener.eventEmitter.removeEventListener(_userVideoStatusChangedListener);
    eventListener.eventEmitter.removeEventListener(_cloudRecordingStatusListener);
    eventListener.eventEmitter.removeEventListener(_networkStatusChangeListener);
    eventListener.eventEmitter.removeEventListener(_requireSystemPermission);
    eventListener.eventEmitter.removeEventListener(_eventErrorListener);

    _timer?.cancel();
    _inactivityTimer?.cancel();

    super.dispose();
  }
}
