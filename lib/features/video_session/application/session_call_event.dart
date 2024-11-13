part of 'session_call_bloc.dart';

@freezed
class SessionCallEvent with _$SessionCallEvent {
  const factory SessionCallEvent.setTimerValue(int sessionTime) = SetTimerValue;

  const factory SessionCallEvent.resetTimerValue() = ResetTimerValue;
}
