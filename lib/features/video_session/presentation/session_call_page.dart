import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';
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
import 'package:wakelock/wakelock.dart';

class SessionCallPage extends StatefulWidget {
  const SessionCallPage({Key? key}) : super(key: key);

  @override
  State<SessionCallPage> createState() => _SessionCallPageState();
}

class _SessionCallPageState extends State<SessionCallPage> with WidgetsBindingObserver {
  ZoomVideoSdk zoom = ZoomVideoSdk();
  ZoomVideoSdkEventListener eventListener = ZoomVideoSdkEventListener();

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
  String sessionName = '';
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isVideoOn = false;
  bool isInSession = false;

  String _error = '';
  Timer? _timer;
  Timer? _inactivityTimer;

  int _sessionStart = 0;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    context.read<SessionCallBloc>().add(const SessionCallEvent.resetTimerValue());
    WidgetsBinding.instance.addObserver(this);

    Wakelock.enable();

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
      _setActiveUserState();
      _inactivityTimer?.cancel();
    }
  }

  _setInactiveUserState() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
    if (mySelf == null) return;

    final audioStatus = mySelf.audioStatus;
    final videoStatus = mySelf.videoStatus;

    if (audioStatus != null) {
      await zoom.audioHelper.muteAudio(mySelf.userId);
    }

    if (videoStatus != null) {
      await zoom.videoHelper.stopVideo();
    }
  }

  _setActiveUserState() async {
    ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
    if (mySelf == null) return;

    final audioStatus = mySelf.audioStatus;
    final videoStatus = mySelf.videoStatus;

    if (audioStatus != null) {
      await zoom.audioHelper.unMuteAudio(mySelf.userId);
    }

    if (videoStatus != null) {
      await zoom.videoHelper.startVideo();
    }
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
      final String sessionName = context.read<TopicsBloc>().state.data.thisWeekTopicName;
      final String? sessionPassword = context.read<TopicsBloc>().state.data.signedGroupSessionPassword;

      final String token = context.read<TopicsBloc>().state.data.signedSessionSignature;

      log('session token = $token', name: 'zoomSessionLog');

      final String userName = context.read<AuthenticationCubit>().state.nickname ??
          context.read<AuthenticationCubit>().state.name;

      JoinSessionConfig joinSession = JoinSessionConfig(
        sessionName: sessionName,
        sessionPassword: sessionPassword ?? ZoomConfig.defaultSessionPwd,
        token: token,
        userName: userName,
        audioOptions: ZoomConfig.sdkAudioOptions,
        videoOptions: ZoomConfig.sdkVideoOptions,
        sessionIdleTimeoutMins: 5,
      );

      try {
        await zoom.joinSession(joinSession);
      } catch (e) {
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

  void _startTimer() {
    if (_timer != null) _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      context.read<SessionCallBloc>().add(SessionCallEvent.setTimerValue(_sessionStart++));
    });
  }

  _initSessionListeners() {
    eventListener.addEventListener();

    var emitter = eventListener.eventEmitter;

    _sessionJoinListener = emitter.on(EventType.onSessionJoin, (sessionUser) async {
      isInSession = true;

      _sessionStart = context.read<TopicsBloc>().state.data.timePassedSinceSessionStart.inSeconds;

      _startTimer();

      log('_sessionJoinListener', name: 'zoomSessionLog');

      ZoomVideoSdkUser mySelf = ZoomVideoSdkUser.fromJson(jsonDecode(sessionUser.toString()));
      List<ZoomVideoSdkUser>? remoteUsers = await zoom.session.getRemoteUsers();
      var muted = await mySelf.audioStatus?.isMuted();
      var videoOn = await mySelf.videoStatus?.isOn();
      var speakerOn = await zoom.audioHelper.getSpeakerStatus();
      var currentSessionName = await zoom.session.getSessionName();

      await zoom.audioHelper.setSpeaker(true);

      _sessionParticipants = [mySelf, ...?remoteUsers];
      isMuted = muted!;
      isSpeakerOn = speakerOn;
      isVideoOn = videoOn!;

      sessionName = currentSessionName!;

      setState(() {});
    });

    _sessionLeaveListener = emitter.on(EventType.onSessionLeave, (data) async {
      isInSession = false;

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

      setState(() {
        _sessionParticipants = [
          mySelf!,
          ...remoteUserListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)).toList()
        ];
      });
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
      // TODO not implemented by zoom team
      log('_cloudRecordingStatusListener - ${data['status']}', name: 'zoomSessionLog');
    });

    _networkStatusChangeListener = emitter.on(EventType.onUserVideoNetworkStatusChanged, (Map data) async {
      ZoomVideoSdkUser? networkUser = ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));

      log('_networkStatusChangeListener - $networkUser ${data['status']}', name: 'zoomSessionLog');

      // TODO handle network status change
      // if (data['status'] == NetworkStatus.Bad) {
      //
      // }
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
    // Remove system app bar on Android
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
  }

  Future _enablePortraitOrientation() async {
    // Restores system app bar on Android
    await SystemChrome.restoreSystemUIOverlays();

    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
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
    await zoom.leaveSession(false);
    if (context.mounted) {
      context.router.pop();
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

  void _showNotSupportSnack() {
    showAppSnackBar(
      context: context,
      text: LocalizedTexts.toggleSpeakerError.tr(),
      background: AppColors.red,
      textColor: Colors.white,
    );
  }

  void onSettingsHandler() {
    showDialog(
        context: context,
        builder: (context) => SettingsDialog(
              onToggleSpeaker: onToggleSpeaker,
              isSpeakerOn: isSpeakerOn,
            ));
  }

  bool get userJoinedToSession => isInSession && _sessionParticipants.isNotEmpty;

  void _onVideoPlayingHandler(bool isVideoPlaying) async {
    isVideoPlaying ? _enableLandscapeOrientation() : _enablePortraitOrientation();

    isVideoPlaying ? muteAllParticipants() : unMuteAllParticipants();

    setState(() {
      _isVideoPlaying = isVideoPlaying;
    });
  }

  void muteAllParticipants() async {
    if (_sessionParticipants.isEmpty) return;

    for (var user in _sessionParticipants) {
      await zoom.audioHelper.muteAudio(user.userId);
    }
  }

  void unMuteAllParticipants() async {
    if (_sessionParticipants.isEmpty) return;

    for (var user in _sessionParticipants) {
      await zoom.audioHelper.unMuteAudio(user.userId);
    }
  }

  Future<void> _onReportIssueHandler() async {
    final signedSessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId;
    if (signedSessionId == null) {
      return;
    }
    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    final timePassed = context.read<TopicsBloc>().state.data.timePassedSinceSessionStart.inSeconds;

    final sessionReport = GroupSessionReport(
      id: signedSessionId,
      time: formatSecondsToDurationString(timePassed),
    );
    ModalBottomSheet.reportAbuse(context: context, groupSession: sessionReport);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
      final hideAppBar = _isVideoPlaying && orientation == Orientation.landscape;

      return Scaffold(
        appBar: hideAppBar ? null : SessionAppBar(sessionName: sessionName, onEndSessionHandler: _endSession),
        body: Container(
          color: AppColors.black,
          child: SafeArea(
            bottom: !hideAppBar,
            child: Stack(
              children: [
                if (!_isVideoPlaying)
                  Container(
                    color: AppColors.bgGreen,
                    child: userJoinedToSession
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: UsersGrid(
                                  users: _sessionParticipants,
                                  talkingUsers: _talkingUsers,
                                  usersWithCameraOff: _usersWithCameraOff,
                                ),
                              ),
                              const Expanded(child: PromptsContainer()),
                              ReportIssue(
                                minutesLeft:
                                    context.read<TopicsBloc>().state.data.timeLeftToSessionStart.inMinutes,
                                onReportIssueHandler: _onReportIssueHandler,
                              ),
                              CallControls(
                                onMuteHandler: onPressAudio,
                                onStopVideoHandler: onPressVideo,
                                isMuted: isMuted,
                                isCameraOn: isVideoOn,
                                onSettingsHandler: onSettingsHandler,
                              )
                            ],
                          )
                        : const Loader(),
                  ),
                if (userJoinedToSession)
                  BlocBuilder<SessionCallBloc, SessionCallState>(
                    builder: (context, state) {
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
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    Wakelock.disable();

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
