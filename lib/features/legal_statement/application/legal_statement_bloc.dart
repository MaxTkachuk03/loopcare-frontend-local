import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

part 'legal_statement_bloc.freezed.dart';

part 'legal_statement_bloc.g.dart';

part 'legal_statement_event.dart';

part 'legal_statement_state.dart';

@singleton
class LegalStatementBloc extends HydratedBloc<LegalStatementEvent, LegalStatementState> {
  final AuthenticationBloc _authenticationBloc;

  late final StreamSubscription _authBlocStreamSubscription;

  LegalStatementBloc(this._authenticationBloc) : super(LegalStatementState.initial()) {
    on<PassageChanged>(_onPassageChanged);

    _authBlocStreamSubscription = _authenticationBloc.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const LegalStatementEvent.passageChanged(false));
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
    Emitter<LegalStatementState> emit,
  ) {
    emit(state.copyWith(pageWasPassed: event.value));
  }

  @override
  LegalStatementState? fromJson(Map<String, dynamic> json) => LegalStatementState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LegalStatementState state) {
    return state.toJson();
  }
}
