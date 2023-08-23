import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/appliction/dto/topic.dart';
import 'package:loopcare_frontend/features/group_sessions/appliction/topics_service.dart';

part 'topics_bloc.freezed.dart';

part 'topics_event.dart';

part 'topics_state.dart';

@singleton
class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final TopicsService topicsService;

  TopicsBloc(this.topicsService) : super(const TopicsState.initial(TopiscData())) {
    on<FetchTopics>(_onFetchTopics);
  }

  FutureOr<void> _onFetchTopics(
    FetchTopics event,
    Emitter<TopicsState> emit,
  ) async {
    final response = await topicsService.fetchTopics();

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
          state.data.copyWith(topics: _combineTopicsByWeek(null, r.data)),
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
