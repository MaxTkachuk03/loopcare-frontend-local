import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'session_call_bloc.freezed.dart';
part 'session_call_event.dart';
part 'session_call_state.dart';

@singleton
class SessionCallBloc extends Bloc<SessionCallEvent, SessionCallState> {
  SessionCallBloc() : super(const SessionCallState.initial(SessionCallData())) {
    on<SetTimerValue>(_onSetTimerValue);
    on<ResetTimerValue>(_onResetTimerValue);
  }

  Future<void> _onSetTimerValue(
    SetTimerValue event,
    Emitter<SessionCallState> emit,
  ) async {
    emit(SessionCallState.updateSessionTime(state.data.copyWith(sessionTime: event.sessionTime)));
  }

  Future<void> _onResetTimerValue(
    ResetTimerValue event,
    Emitter<SessionCallState> emit,
  ) async {
    emit(SessionCallState.updateSessionTime(state.data.copyWith(sessionTime: 0)));
  }
}
