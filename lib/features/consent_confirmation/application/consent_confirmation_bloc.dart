import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

part 'consent_confirmation_bloc.freezed.dart';

part 'consent_confirmation_bloc.g.dart';

part 'consent_confirmation_event.dart';

part 'consent_confirmation_state.dart';

@singleton
class ConsentConfirmationBloc
    extends HydratedBloc<ConsentConfirmationEvent, ConsentConfirmationState> {
  final AuthenticationBloc _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  ConsentConfirmationBloc(this._authenticationCubit)
      : super(ConsentConfirmationState.initial()) {
    on<PassageChanged>(_onPassageChanged);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const ConsentConfirmationEvent.passageChanged(false));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authBlocStreamSubscription.cancel();

    return super.close();
  }

  FutureOr<void> _onPassageChanged(
    PassageChanged event,
    Emitter<ConsentConfirmationState> emit,
  ) {
    emit(state.copyWith(pageWasPassed: event.value));
  }

  @override
  ConsentConfirmationState? fromJson(Map<String, dynamic> json) =>
      ConsentConfirmationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ConsentConfirmationState state) {
    return state.toJson();
  }
}
