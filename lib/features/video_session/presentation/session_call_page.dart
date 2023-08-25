import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/video_session/presentation/config.dart';
import 'package:loopcare_frontend/features/video_session/presentation/jwt.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/call_controls.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/error_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/prompts_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/report_issue.dart';
// import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_video_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/settings_dialog.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/users_grid.dart';

class SessionCallPage extends StatefulWidget {
  const SessionCallPage({Key? key}) : super(key: key);

  @override
  State<SessionCallPage> createState() => _SessionCallPageState();
}

class _SessionCallPageState extends State<SessionCallPage> {
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

  List<ZoomVideoSdkUser> users = [];
  List<String> talkingUsers = [];
  String sessionName = '';
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isVideoOn = false;
  bool isInSession = false;
  bool isRecordingStarted = false;
  bool isReceiveSpokenLanguageContentEnabled = false;

  String _error = '';
  late Timer _timer;
  int _sessionStart = 0;
  double aspectRatio = 1;

  @override
  void initState() {
    _initSessionListeners();
    _joinSession();

    super.initState();
  }

  void _joinSession() {
    Future<void>.microtask(() async {
      final String token = generateJwt(defaultSessionName, defaultSessionRole);

      JoinSessionConfig joinSession = JoinSessionConfig(
        sessionName: defaultSessionName,
        sessionPassword: defaultSessionPwd,
        token: token,
        userName: context.read<AuthenticationCubit>().state.name,
        audioOptions: sdkAudioOptions,
        videoOptions: sdkVideoOptions,
        sessionIdleTimeoutMins: 5,
      );

      try {
        await zoom.joinSession(joinSession);
      } catch (e) {
        print('error during join session $e');
        const AlertDialog(title: Text("Error"), content: Text("Failed to join the session"));
      }
    });
  }

  void _reconnectToTheSession() {
    Timer(const Duration(milliseconds: 500), () async {
      await zoom.leaveSession(false);
      _joinSession();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _sessionStart++;
      });
    });
  }

  _initSessionListeners() {
    eventListener.addEventListener();

    var emitter = eventListener.eventEmitter;

    _sessionJoinListener = emitter.on(EventType.onSessionJoin, (sessionUser) async {
      isInSession = true;
      // TODO set initial _sessionStart value = TimeStamp.now() - sessionStartTime
      _startTimer();

      ZoomVideoSdkUser mySelf = ZoomVideoSdkUser.fromJson(jsonDecode(sessionUser.toString()));
      List<ZoomVideoSdkUser>? remoteUsers = await zoom.session.getRemoteUsers();
      var muted = await mySelf.audioStatus?.isMuted();
      var videoOn = await mySelf.videoStatus?.isOn();
      var speakerOn = await zoom.audioHelper.getSpeakerStatus();
      var currentSessionName = await zoom.session.getSessionName();

      await zoom.audioHelper.setSpeaker(false);
      // final a = await zoom.recordingHelper.startCloudRecording();
      // print('startCloudRecording status $a');

      remoteUsers?.insert(0, mySelf);
      users = remoteUsers!;
      isMuted = muted!;
      isSpeakerOn = speakerOn;
      isVideoOn = videoOn!;
      users = remoteUsers;
      sessionName = currentSessionName!;
      isReceiveSpokenLanguageContentEnabled =
          await zoom.liveTranscriptionHelper.isReceiveSpokenLanguageContentEnabled();

      setState(() {});
    });

    _sessionLeaveListener = emitter.on(EventType.onSessionLeave, (data) async {
      isInSession = false;
      final a = await zoom.recordingHelper.stopCloudRecording();
      print('stopCloudRecording status $a');

      _timer.cancel();

      users = <ZoomVideoSdkUser>[];

      setState(() {});
    });

    _userJoinListener = emitter.on(EventType.onUserJoin, (Map data) async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      var userListJson = jsonDecode(data['remoteUsers']) as List;
      final List<ZoomVideoSdkUser> remoteUserList = [];
      remoteUserList.add(mySelf!);
      remoteUserList.addAll(userListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)));

      setState(() {
        users = remoteUserList;
      });
    });

    _userLeaveListener = emitter.on(EventType.onUserLeave, (Map data) async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      var remoteUserListJson = jsonDecode(data['remoteUsers']) as List;

      List<ZoomVideoSdkUser> remoteUserList =
          remoteUserListJson.map((userJson) => ZoomVideoSdkUser.fromJson(userJson)).toList();

      remoteUserList.add(mySelf!);

      setState(() {
        users = remoteUserList;
      });
    });

    _userActiveAudioChangedListener = emitter.on(EventType.onUserActiveAudioChanged, (Map data) async {
      // Gets list of user who are speaking at the moment
      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      talkingUsers = userList.map((u) => u.userId).toList();

      setState(() {});
    });

    _userAudioStatusChangedListener = emitter.on(EventType.onUserAudioStatusChanged, (Map data) async {
      final ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      for (var user in userList) {
        if (user.userId != mySelf?.userId) return;
        mySelf?.audioStatus?.isMuted().then((muted) => isMuted = muted);
      }

      setState(() {});
    });

    _userVideoStatusChangedListener = emitter.on(EventType.onUserVideoStatusChanged, (Map data) async {
      final ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();

      final List<ZoomVideoSdkUser> userList = _getSessionChangedUsers(data);

      for (var user in userList) {
        if (user.userId != mySelf?.userId) return;
        mySelf?.videoStatus?.isOn().then((on) => isVideoOn = on);
      }

      setState(() {});
    });

    _cloudRecordingStatusListener = emitter.on(EventType.onCloudRecordingStatus, (Map data) async {
      print('_cloudRecordingStatusListener - ${data['status']}');
      // ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      await zoom.acceptRecordingConsent();
      // if (data['status'] == RecordingStatus.Start) {
      //   if (mySelf != null && !mySelf.isHost!) {
      //     showDialog<String>(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //         content: const Text('The session is being recorded.'),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () async {
      //               await zoom.acceptRecordingConsent();
      //               if (context.mounted) {
      //                 Navigator.pop(context);
      //               }
      //               ;
      //             },
      //             child: const Text('accept'),
      //           ),
      //           TextButton(
      //             onPressed: () async {
      //               String currentConsentType = await zoom.getRecordingConsentType();
      //               if (currentConsentType == ConsentType.ConsentType_Individual) {
      //                 await zoom.declineRecordingConsent();
      //                 Navigator.pop(context);
      //               } else {
      //                 await zoom.declineRecordingConsent();
      //                 zoom.leaveSession(false);
      //                 if (!context.mounted) return;
      //                 Navigator.popAndPushNamed(
      //                   context,
      //                   "Join",
      //                   arguments: JoinArguments(args.isJoin, sessionName.value, sessionPassword.value,
      //                       args.displayName, args.sessionIdleTimeoutMins, args.role),
      //                 );
      //               }
      //             },
      //             child: const Text('decline'),
      //           ),
      //         ],
      //       ),
      //     );
      //   }
      //   isRecordingStarted = true;
      // } else {
      //   isRecordingStarted = false;
      // }
    });

    _networkStatusChangeListener = emitter.on(EventType.onUserVideoNetworkStatusChanged, (Map data) async {
      ZoomVideoSdkUser? networkUser = ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));

      print('_networkStatusChangeListener $networkUser ${data['status']}');

      if (data['status'] == NetworkStatus.Bad) {
        debugPrint(
            "onUserVideoNetworkStatusChanged: status: ${data['status']}, user: ${networkUser.userName}");
      }
    });

    _requireSystemPermission = emitter.on(EventType.onRequireSystemPermission, (Map data) async {
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
            _onErrorHandler(errorType);
          },
        ),
      );
    });
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
      text: 'Device not support speaker toggle',
      background: AppColors.red,
      textColor: Colors.white,
    );
  }

  void onToggleAspectRatio() {
    setState(() {
      aspectRatio = aspectRatio == 1 ? 0.57 : 1;
    });
  }

  void onSettingsHandler() {
    showDialog(
        context: context,
        builder: (context) => SettingsDialog(
              onToggleSpeaker: onToggleSpeaker,
              onToggleAspectRatio: onToggleAspectRatio,
              isSpeakerOn: isSpeakerOn,
            ));
  }

  bool get userJoinedToSession => isInSession && users.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: sessionName,
        subtitle: 'Duration ${formatSecondsToDurationString(_sessionStart)}',
        actions: [
          IconButton(
            iconSize: 45.0,
            onPressed: _endSession,
            icon: AppIcons.greenPhone,
          )
        ],
      ),
      body: Container(
        color: AppColors.black,
        child: SafeArea(
          bottom: true,
          child: Stack(
            children: [
              Container(
                color: AppColors.bgGreen,
                child: userJoinedToSession
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: UsersGrid(
                              users: users,
                              talkingUsers: talkingUsers,
                              aspectRatio: aspectRatio,
                            ),
                          ),
                          const Expanded(child: PromptsContainer()),
                          const ReportIssue(minutesLeft: '19'),
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
              // const SessionVideoContainer(),// will be user for video
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
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

    _timer.cancel();

    super.dispose();
  }
}
