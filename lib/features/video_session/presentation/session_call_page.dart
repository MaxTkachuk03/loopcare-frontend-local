// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/time_service/time_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/call_controls.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/error_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/info_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/prompts_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/report_issue.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_app_bar.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_video_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/settings_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/users_grid.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

@RoutePage()
class SessionCallPage extends StatefulWidget {
  const SessionCallPage({super.key});

  @override
  State<SessionCallPage> createState() => _SessionCallPageState();
}

class _SessionCallPageState extends State<SessionCallPage> with WidgetsBindingObserver {
  final ZoomVideoSdk _zoom = ZoomVideoSdk();
  final ZoomVideoSdkEventListener _eventListener = ZoomVideoSdkEventListener();

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
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isVideoOn = false;
  bool _isInSession = false;
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
    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    final userMuteState = await _zoom.audioHelper.muteAudio(mySelf!.userId);
    await _zoom.videoHelper.stopVideo();
    _showToggleMicPopup(status: userMuteState, isOn: false);
  }

  _setActiveUserState(bool isVideoPlaying) async {
    if (isVideoPlaying) return;
    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    final userMuteState = await _zoom.audioHelper.unMuteAudio(mySelf!.userId);
    await _zoom.videoHelper.startVideo();
    _showToggleMicPopup(status: userMuteState, isOn: true);
  }

  void _showToggleMicPopup({String status = '', bool isOn = false}) {
    final micState = isOn ? LocalizedTexts.on : LocalizedTexts.off;

    status == Errors.Success
        ? context.showSuccessBar(
            content: CustomText(
              LocalizedTexts.micState.tr({"micState": micState}),
            ),
          )
        : context.showError(content: CustomText(LocalizedTexts.errorSomethingWentWrong.tr()));
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
      final String? sessionPassword =
          context.read<TopicsBloc>().state.data.signedGroupSessionPassword;
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
        await _zoom.joinSession(joinSession);
      } catch (e) {
        log('Error while join session $e', name: 'zoomSessionLog');
        const AlertDialog(title: Text("Error"), content: Text("Failed to join the session"));
      }
    });
  }

  void _reconnectToTheSession() {
    _timer?.cancel();
    Timer(const Duration(milliseconds: 500), () async {
      await _zoom.leaveSession(false);
      _joinSession();
    });
  }

  void _startTimer() async {
    if (_timer != null) _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final startTime = context.read<TopicsBloc>().state.data.signedGroupSessionStartTime;
      final Duration passedTime =
          startTime != null ? await TimeService.passedFromNtp(startTime) : Duration.zero;

      if (mounted) {
        context.read<SessionCallBloc>().add(SessionCallEvent.setTimerValue(passedTime.inSeconds));
      }
    });
  }

  _initSessionListeners() {
    _eventListener.addEventListener();

    var emitter = _eventListener.eventEmitter;

    _sessionJoinListener = emitter.on(EventType.onSessionJoin, _onSessionJoin);
    _sessionLeaveListener = emitter.on(EventType.onSessionLeave, _onSessionLeave);
    _userJoinListener = emitter.on(EventType.onUserJoin, _onUserJoin);
    _userLeaveListener = emitter.on(EventType.onUserLeave, _onUserLeave);
    _userActiveAudioChangedListener =
        emitter.on(EventType.onUserActiveAudioChanged, _onUserAudioChanged);
    _userAudioStatusChangedListener =
        emitter.on(EventType.onUserAudioStatusChanged, _onUserAudioStatusChanged);
    _userVideoStatusChangedListener =
        emitter.on(EventType.onUserVideoStatusChanged, _onUserVideoStatusChanged);
    _cloudRecordingStatusListener =
        emitter.on(EventType.onCloudRecordingStatus, _onCloudRecordingStatus);
    _networkStatusChangeListener =
        emitter.on(EventType.onUserVideoNetworkStatusChanged, _onUserVideoNetworkStatusChanged);
    _requireSystemPermission =
        emitter.on(EventType.onRequireSystemPermission, _onRequiredSystemPermissions);
    _eventErrorListener = emitter.on(EventType.onError, _onError);
  }

  Future<void> _onSessionJoin(sessionUser) async {
    _isInSession = true;

    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.userEntersSession);

    _startTimer();

    log('_sessionJoinListener', name: 'zoomSessionLog');

    ZoomVideoSdkUser mySelf = ZoomVideoSdkUser.fromJson(jsonDecode(sessionUser.toString()));
    List<ZoomVideoSdkUser>? remoteUsers = await _zoom.session.getRemoteUsers();
    var muted = await mySelf.audioStatus?.isMuted();
    var videoOn = await mySelf.videoStatus?.isOn();
    var speakerOn = await _zoom.audioHelper.getSpeakerStatus();

    if (!_isCloudRecordingActive) {
      await _zoom.recordingHelper.startCloudRecording();
    }

    await _zoom.audioHelper.setSpeaker(true);

    _sessionParticipants = [mySelf, ...?remoteUsers];
    _isMuted = muted!;
    _isSpeakerOn = speakerOn;
    _isVideoOn = videoOn!;

    setState(() {});
  }

  Future<void> _onSessionLeave(data) async {
    _isInSession = false;

    if (_isCloudRecordingActive) {
      await _zoom.recordingHelper.stopCloudRecording();
    }

    log('_sessionLeaveListener $data', name: 'zoomSessionLog');

    _timer?.cancel();

    _sessionParticipants = <ZoomVideoSdkUser>[];

    setState(() {});
  }

  Future<void> _onUserJoin(Map data) async {
    log('_userJoinListener $data', name: 'zoomSessionLog');

    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    var userListJson = jsonDecode(data['remoteUsers']) as List;

    setState(() {
      _sessionParticipants = [
        mySelf!,
        ...userListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
      ];
    });
  }

  Future<void> _onUserLeave(Map data) async {
    log('_userLeaveListener $data', name: 'zoomSessionLog');

    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    var remoteUserListJson = jsonDecode(data['remoteUsers']) as List;

    if (context.mounted) {
      setState(() {
        _sessionParticipants = [
          mySelf!,
          ...remoteUserListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)),
        ];
      });
    }
  }

  void _onUserAudioChanged(Map data) {
    // Gets list of user who are speaking at the moment
    final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

    _talkingUsers = userList.map((u) => u.userId).toList();

    setState(() {});
  }

  Future<void> _onUserAudioStatusChanged(Map data) async {
    log('_userAudioStatusChangedListener $data', name: 'zoomSessionLog');

    final ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();

    final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

    for (var user in userList) {
      if (user.userId != mySelf?.userId) return;
      mySelf?.audioStatus?.isMuted().then((muted) => _isMuted = muted);
    }

    setState(() {});
  }

  Future<void> _onUserVideoStatusChanged(Map data) async {
    log('_userVideoStatusChangedListener $data', name: 'zoomSessionLog');

    final ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();

    final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

    List<String> usersWithCameraOff = [];

    for (var user in userList) {
      user.videoStatus?.isOn().then((value) {
        if (!value) usersWithCameraOff.add(user.userId);
        if (user.userId == mySelf?.userId) _isVideoOn = value;
      });
    }

    _usersWithCameraOff = usersWithCameraOff;

    setState(() {});
  }

  void _onCloudRecordingStatus(Map data) {
    log('_cloudRecordingStatusListener - ${data['status']}', name: 'zoomSessionLog');

    _isCloudRecordingActive = data['status'] == 'ZoomVideoSDKRecordingStatus_Start';
    setState(() {});
  }

  void _onUserVideoNetworkStatusChanged(Map data) {
    ZoomVideoSdkUser? networkUser = ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));

    log('_networkStatusChangeListener - $networkUser ${data['status']}', name: 'zoomSessionLog');

    if (data['status'] == NetworkStatus.Bad) {
      context.showError(content: CustomText(LocalizedTexts.badConnectionMessage.tr()));
    }
  }

  void _onRequiredSystemPermissions(Map data) {
    log('_requireSystemPermission - $data', name: 'zoomSessionLog');

    var permissionType = data['permissionType'];

    switch (permissionType) {
      case SystemPermissionType.Camera:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => InformationDialog(
            title: LocalizedTexts.noCameraAccessTitle.tr(),
            content: LocalizedTexts.noCameraAccessDescription.tr(),
          ),
        );
        break;
      case SystemPermissionType.Microphone:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => InformationDialog(
            title: LocalizedTexts.noMicrophoneAccessTitle.tr(),
            content: LocalizedTexts.noMicrophoneAccessDescription.tr(),
          ),
        );
        break;
    }
  }

  void _onError(Map data) async {
    String errorType = data['errorType'];
    log('_eventErrorListener called with $errorType', name: 'zoomSessionLog');
    if (_error == errorType) return;

    _error = errorType;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ErrorDialog(
        errorText: errorType,
        onErrorHandler: () {
          context.router.maybePop();
          if (!_isInSession) _onErrorHandler(errorType);
        },
      ),
    );
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
      onStayPressed: context.router.maybePop,
    );
  }

  _leaveSessionHandler() async {
    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.userLeaveSession);
    await _zoom.leaveSession(false);
    if (context.mounted) {
      context.router.maybePop();
    }
  }

  _forceEndSession() async {
    await _zoom.leaveSession(true);

    if (context.mounted) {
      context.router.popUntilRouteWithPath(AppRoutes.home);
      context.showSuccessBar(content: CustomText(LocalizedTexts.sessionEndDialogText.tr()));
    }
  }

  void onPressAudio() async {
    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    if (mySelf == null) return;

    final audioStatus = mySelf.audioStatus;

    if (audioStatus == null) return;

    final bool muted = await audioStatus.isMuted();

    if (muted) {
      await _zoom.audioHelper.unMuteAudio(mySelf.userId);
    } else {
      await _zoom.audioHelper.muteAudio(mySelf.userId);
    }
  }

  void onPressVideo() async {
    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();
    if (mySelf == null) return;

    final videoStatus = mySelf.videoStatus;

    if (videoStatus == null) return;

    final bool videoOn = await videoStatus.isOn();

    if (videoOn) {
      await _zoom.videoHelper.stopVideo();
    } else {
      await _zoom.videoHelper.startVideo();
    }
  }

  void onToggleSpeaker() async {
    ZoomVideoSdkUser? mySelf = await _zoom.session.getMySelf();

    if (mySelf == null) return;

    if (!await _zoom.audioHelper.canSwitchSpeaker()) _showNotSupportSnack();

    await _zoom.audioHelper.setSpeaker(!_isSpeakerOn);

    final isOn = await _zoom.audioHelper.getSpeakerStatus();

    setState(() {
      _isSpeakerOn = isOn;
    });
  }

  void _showNotSupportSnack() =>
      context.showError(content: CustomText(LocalizedTexts.toggleSpeakerError.tr()));

  void onSettingsHandler() {
    showDialog(
      context: context,
      builder: (context) =>
          SettingsDialog(onToggleSpeaker: onToggleSpeaker, isSpeakerOn: _isSpeakerOn),
    );
  }

  bool get userJoinedToSession => _isInSession && _sessionParticipants.isNotEmpty;

  void _onVideoPlayingHandler(bool isVideoPlaying) async {
    if (isVideoPlaying) {
      _enableLandscapeOrientation();
      _setInactiveUserState();
    } else {
      _enablePortraitOrientation();
      await _zoom.videoHelper.startVideo();
    }

    setState(() {
      _isVideoPlaying = isVideoPlaying;
    });
  }

  Future<void> _onReportIssueHandler() async {
    final signedSessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId;
    if (signedSessionId == null) return;

    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    final startTime = context.read<TopicsBloc>().state.data.signedGroupSessionStartTime;
    final Duration timePassed =
        startTime != null ? await TimeService.passedFromNtp(startTime) : Duration.zero;

    final sessionReport = GroupSessionReport(
      id: signedSessionId,
      time: formatSecondsToTimeString(timePassed.inSeconds),
    );

    if (mounted) {
      ModalBottomSheet.reportAbuse(context: context, groupSession: sessionReport);
    }

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.groupSessionReportedIssue,
      parameters: {
        AnalyticsParameters.sessionId: signedSessionId,
        AnalyticsParameters.timePassed: formatSecondsToTimeString(timePassed.inSeconds),
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
                if (!_isVideoPlaying && userJoinedToSession)
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
                if (userJoinedToSession)
                  BlocBuilder<SessionCallBloc, SessionCallState>(
                    builder: (context, state) {
                      final currentSession =
                          context.read<TopicsBloc>().state.data.signedGroupSession;

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
                  )
                else
                  const Loader()
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
                          isMuted: _isMuted,
                          isCameraOn: _isVideoOn,
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

    _zoom.leaveSession(false);

    _eventListener.eventEmitter.listeners.map((e) => e.cancel());

    _eventListener.eventEmitter.removeEventListener(_sessionJoinListener);
    _eventListener.eventEmitter.removeEventListener(_userJoinListener);
    _eventListener.eventEmitter.removeEventListener(_userLeaveListener);
    _eventListener.eventEmitter.removeEventListener(_sessionLeaveListener);
    _eventListener.eventEmitter.removeEventListener(_userAudioStatusChangedListener);
    _eventListener.eventEmitter.removeEventListener(_userActiveAudioChangedListener);
    _eventListener.eventEmitter.removeEventListener(_userVideoStatusChangedListener);
    _eventListener.eventEmitter.removeEventListener(_cloudRecordingStatusListener);
    _eventListener.eventEmitter.removeEventListener(_networkStatusChangeListener);
    _eventListener.eventEmitter.removeEventListener(_requireSystemPermission);
    _eventListener.eventEmitter.removeEventListener(_eventErrorListener);

    _timer?.cancel();
    _inactivityTimer?.cancel();

    super.dispose();
  }
}
