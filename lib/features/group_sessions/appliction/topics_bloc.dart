import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
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
    // final response = await diabetesService.diabetesTypes();

    // response.fold(
    //   (l) => null,
    //   (r) => emit(
    //     state.copyWith(diabetesTypes: r.data.toIList()),
    //   ),
    // );
  }
}
