class AppMixpanelEvents {
  const AppMixpanelEvents._();

  static String get appStart => 'App_Start';
  static String get appRote => 'App_Route';
  static String get loginSuccess => 'AuthenticationCubit_login_success ';
  static String get sessionVideoSuccess =>'SessionVideoContainer_video_playing_success';
  static String get sessionVideoEnd =>'SessionVideoContainer_video_playing_end';
  static String get sessionVideoClose =>'SessionVideoContainer_video_playing_close';

  static String get loginFail => 'AuthenticationCubit_login_fail ';
  static String get joinSessionFail =>'SessionCallPage_joinSession_fail';
  static String get sessionFail =>'SessionCallPage_session_fail';
  static String get videoBlockFail =>'VideoBlock_player_fail';
}
