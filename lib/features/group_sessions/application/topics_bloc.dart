import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/group_session_status.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/topic.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_service.dart';

part 'topics_bloc.freezed.dart';

part 'topics_event.dart';

part 'topics_state.dart';

@singleton
class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final TopicsService topicsService;

  TopicsBloc(this.topicsService) : super(const TopicsState.initial(TopicsData())) {
    on<FetchTopics>(_onFetchTopics);
    on<GetSessionSignature>(_onGetSessionSignature);
    on<SignUpToSession>(_onSignUpToSession);
    on<SignOutFromSession>(_onSignOutFromSession);
  }

  FutureOr<void> _onFetchTopics(
    FetchTopics event,
    Emitter<TopicsState> emit,
  ) async {
    await _fetchTopics(emit);
  }

  FutureOr<void> _onSignUpToSession(
    SignUpToSession event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsState.loading(state.data.copyWith(isLoading: true)));

    final response = await topicsService.signToGroupMeeting(event.sessionId);

    await response.fold(
      (l) async => emit(TopicsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) async {
        await _fetchTopics(emit);
      },
    );
  }

  FutureOr<void> _onSignOutFromSession(
    SignOutFromSession event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await topicsService.signOutGroupMeeting(event.sessionId);
    await response.fold(
      (l) async => emit(TopicsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) async {
        await _fetchTopics(emit);
      },
    );
  }

  FutureOr<void> _onGetSessionSignature(
    GetSessionSignature event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsState.loading(state.data.copyWith(isLoading: true)));

    final response = await topicsService.getSessionSignature(event.sessionId);

    response.fold(
      (l) => emit(TopicsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(TopicsState.updated(
        state.data.copyWith(signedSessionSignature: r.signature, error: null, isLoading: false),
      )),
    );
  }

  Future<List<Topic>> _mockData() async {
    String response = await rootBundle.loadString('assets/group.json');
    List<dynamic> result = json.decode(response);
    return result.map((n) => Topic.fromJson(n)).toList();
  }

  Future<void> _fetchTopics(Emitter<TopicsState> emit) async {
    emit(TopicsState.loading(state.data.copyWith(isLoading: true)));

    // TODO will be user as query params for get topics for the current week
    final firstDayOfTheWeek = DateTime.now().firstDayOfCurrentWeek;
    final lastDayOfTheWeek = DateTime.now().lastDayOfCurrentWeek;

    final response = await topicsService.fetchTopics(
      startDate: firstDayOfTheWeek.toUtc().toIso8601String(),
      endDate: lastDayOfTheWeek.toUtc().toIso8601String(),
    );
    // var mockData = await _mockData();

    response.fold(
      (l) => emit(
        TopicsState.error(
          state.data.copyWith(
            error: l,
            isLoading: false,
          ),
        ),
      ),
      (r) => emit(
        TopicsState.updated(
          state.data.copyWith(
            topics: _combineTopicsByWeek(null, r.data),
            // topics: _combineTopicsByWeek(null, mockData),
            error: null,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Map<int, Topic> _combineTopicsByWeek(
    Map<int, Topic>? previousData,
    List<Topic> data,
  ) {
    Map<int, Topic> elements = Map<int, Topic>.from(previousData ?? {});

    for (var element in data) {
      elements[element.groupSessions.first.startDate.weekNumber] = element;
    }

    return elements;
  }
}
