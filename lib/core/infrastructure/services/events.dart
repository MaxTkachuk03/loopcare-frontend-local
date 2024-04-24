class AppMixpanelEvents {
  const AppMixpanelEvents._();

  static String get appStart => 'App_Start';
  static String get appRote => 'App_Route';
  static String get loginSuccess => 'AuthenticationCubit_login_success ';
  static String get sessionVideoSuccess => 'SessionVideoContainer_video_playing_success';
  static String get sessionVideoPlayerInitStart => 'SessionVideoContainer_video_player_init_start';
  static String get sessionVideoPlayerInitFinished => 'SessionVideoContainer_video_player_init_finished';
  static String get sessionVideoEnd => 'SessionVideoContainer_video_playing_end';
  static String get sessionVideoClose => 'SessionVideoContainer_video_playing_close';

  static String get loginFail => 'AuthenticationCubit_login_fail ';
  static String get joinSessionFail => 'SessionCallPage_joinSession_fail';
  static String get onSessionJoin => 'SessionCallPage_user_join_session';
  static String get sessionFail => 'SessionCallPage_session_fail';
  static String get videoBlockFail => 'VideoBlock_player_fail';
  static String get sessionInactiveState => 'SessionCallPage_user_inactive_state';
  static String get sessionActiveState => 'SessionCallPage_user_active_state';

  static String get updateToken => 'AuthTokenInterceptor_refresh_token_update';
  static String get succeedUpdateToken => 'AuthTokenInterceptor_succeed_token_update';
  static String get failedUpdateToken => 'AuthTokenInterceptor_failed_token_update';

  static String get appflyerSdkStartError => 'appflyer_sdk_start_error';
}
