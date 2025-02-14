import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/activity_tracker/domain/activity_service.dart';
import '../../../core/infrastructure/dio_client/request_error.dart';
import 'dto/get_activity_response.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

@singleton
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityService _activityService;

  ActivityBloc(this._activityService) : super(const ActivityState.initial(ActivityData())) {
    on<ActivityInit>(_onInit);
    on<GetActivity>(_onGetActivity);
    on<SaveActivity>(_onSaveActivity);
  }

  Future<void> _onInit(
    ActivityInit event,
    Emitter<ActivityState> emit,
  ) async {}

  Future<void> _onGetActivity(
    GetActivity event,
    Emitter<ActivityState> emit,
  ) async {
    final startDate = event.startDate;
    final endDate = event.endDate;

    final response = await _activityService.getActivities(startDate, endDate);

    response.fold(
      (l) =>
          emit(ActivityState.errorGettingContent(state.data.copyWith(error: l, isLoading: false))),
      (r) async {
        emit(
          ActivityState.getActivity(
            state.data.copyWith(data: r.data),
          ),
        );
        emit(ActivityState.loading(state.data.copyWith(isLoading: false)));
      },
    );
  }

  Future<void> _onSaveActivity(
    SaveActivity event,
    Emitter<ActivityState> emit,
  ) async {
    final body = event.body;
    await _activityService.saveActivities(body);

    emit(ActivityState.errorGettingContent(state.data.copyWith(error: null, isLoading: false)));
  }
}
