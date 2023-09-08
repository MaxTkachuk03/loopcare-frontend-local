import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';

part 'physical_activities_preferences_bloc.freezed.dart';

part 'physical_activities_preferences_event.dart';

part 'physical_activities_preferences_state.dart';

@singleton
class PhysicalActivitiesPreferencesBloc
    extends Bloc<PhysicalActivitiesPreferencesEvent, PhysicalActivitiesPreferencesState> {
  final PhysicalActivitiesService _physicalActivitiesService;

  PhysicalActivitiesPreferencesBloc(this._physicalActivitiesService)
      : super(const PhysicalActivitiesPreferencesState.initial(PhysicalActivitiesPreferencesData())) {
    on<_GetPreferences>(_onGetPreferences);
    on<_SetPreferences>(_onSetPreferences);
  }

  FutureOr<void> _onGetPreferences(
    _GetPreferences event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final response = await _physicalActivitiesService.getPreferences();

    response.fold(
      (l) => emit(PhysicalActivitiesPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        PhysicalActivitiesPreferencesState.preferencesLoaded(
          state.data.copyWith(
            trainingFrequency: r.trainingFrequency ?? '',
            trainingTargets: r.trainingTargets ?? '',
            flexible: r.flexible ?? false,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSetPreferences(
    _SetPreferences event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _physicalActivitiesService.setPreferences(
      PhysicalActivitiesPreferencesBody(
        trainingFrequency: event.data.trainingFrequency ?? '',
        trainingTargets: event.data.trainingTargets ?? '',
        flexible: event.data.flexible ?? false,
      ),
    );

    response.fold(
      (l) => emit(PhysicalActivitiesPreferencesState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        PhysicalActivitiesPreferencesState.preferencesLoaded(
          state.data.copyWith(
            isLoading: false,
            error: null,
          ),
        ),
      ),
    );
  }
}
