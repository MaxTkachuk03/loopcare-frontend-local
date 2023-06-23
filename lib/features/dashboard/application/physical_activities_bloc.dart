import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_helpers.dart';

part 'physical_activities_event.dart';
part 'physical_activities_state.dart';
part 'physical_activities_bloc.freezed.dart';

@singleton
class PhysicalActivitiesBloc extends Bloc<PhysicalActivitiesEvent, PhysicalActivitiesState> {
  final PhysicalActivitiesService _physicalActivitiesService;

  PhysicalActivitiesBloc(this._physicalActivitiesService)
      : super(const PhysicalActivitiesState.initial(PhysicalActivitiesData())) {
    on<_GetWeeklyPhysicalActivities>(_onGetWeeklyPhysicalActivities);
  }

  FutureOr<void> _onGetWeeklyPhysicalActivities(
    _GetWeeklyPhysicalActivities event,
    Emitter<PhysicalActivitiesState> emit,
  ) async {
    emit(PhysicalActivitiesState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _physicalActivitiesService.getProgramsByDate(
      startDate: DateHelpers.findFirstDateOfTheWeek(event.selectedDay).isoStringWithoutTime,
      endDate: DateHelpers.findLastDateOfTheWeek(event.selectedDay).isoStringWithoutTime,
    );

    response.fold(
      (l) => emit(PhysicalActivitiesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(PhysicalActivitiesState.activitiesLoaded(
          state.data.copyWith(weeklyActivities: r.data, isLoading: false, error: null))),
    );
  }
}
