<<<<<<< HEAD
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

part 'legal_statement_bloc.freezed.dart';
part 'legal_statement_bloc.g.dart';
part 'legal_statement_event.dart';
part 'legal_statement_state.dart';

@singleton
class LegalStatementBloc extends HydratedBloc<LegalStatementEvent, LegalStatementState> {
  final AuthenticationBloc _authenticationBloc;
  final usageAnalytics = UsageAnalytics();

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
    if (event.value) {
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.legalStatement,
        parameters: {
          AnalyticsParameters.value: 'true',
        },
      );
    }

    usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingRegisterIntro);

    emit(state.copyWith(pageWasPassed: event.value));
  }

  @override
  LegalStatementState? fromJson(Map<String, dynamic> json) => LegalStatementState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LegalStatementState state) {
    return state.toJson();
  }
}
=======
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

part 'legal_statement_bloc.freezed.dart';
part 'legal_statement_bloc.g.dart';
part 'legal_statement_event.dart';
part 'legal_statement_state.dart';

@singleton
class LegalStatementBloc extends HydratedBloc<LegalStatementEvent, LegalStatementState> {
  final AuthenticationBloc _authenticationBloc;
  final usageAnalytics = UsageAnalytics();

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
    if (event.value) {
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.legalStatement,
        parameters: {
          AnalyticsParameters.value: 'true',
        },
      );
    }

    usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingRegisterIntro);

    emit(state.copyWith(pageWasPassed: event.value));
  }

  @override
  LegalStatementState? fromJson(Map<String, dynamic> json) => LegalStatementState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LegalStatementState state) {
    return state.toJson();
  }
}
>>>>>>> feature-interactive-lessons
