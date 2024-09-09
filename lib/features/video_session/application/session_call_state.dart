part of 'session_call_bloc.dart';

@freezed
class SessionCallState with _$SessionCallState {
  const factory SessionCallState.initial(SessionCallData data) = SessionCallStateInitial;

  const factory SessionCallState.updateSessionTime(SessionCallData data) =
      SessionCallStateUpdateSessionTime;
}

@freezed
class SessionCallData with _$SessionCallData {
  const SessionCallData._();

  const factory SessionCallData({
    @Default(0) int sessionTime,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _SessionCallData;
}
