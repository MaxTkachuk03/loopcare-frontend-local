import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';

part 'physical_activities_preferences_bloc.freezed.dart';
part 'physical_activities_preferences_event.dart';
part 'physical_activities_preferences_state.dart';

@singleton
class PhysicalActivitiesPreferencesBloc
    extends Bloc<PhysicalActivitiesPreferencesEvent, PhysicalActivitiesPreferencesState> {
  final PhysicalActivitiesService _physicalActivitiesService;

  PhysicalActivitiesPreferencesBloc(this._physicalActivitiesService)
      : super(
            const PhysicalActivitiesPreferencesState.initial(PhysicalActivitiesPreferencesData())) {
    on<_Init>(_onInit);
    on<_GetPreferences>(_onGetPreferences);
    on<_SavePreferences>(_onSavePreferences);
    on<_SetFrequency>(_onSetFrequency);
    on<_SetTargets>(_onSetTargets);
    on<_SetFlexible>(_onSetFlexible);
  }

  FutureOr<void> _onInit(
    _Init event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(const PhysicalActivitiesPreferencesState.initial(PhysicalActivitiesPreferencesData()));
  }

  FutureOr<void> _onSetFrequency(
    _SetFrequency event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.preferencesLoaded(
      state.data.copyWith(
        trainingFrequency: event.data,
        trainingTargets:
            event.data == PhysicalActivitiesFrequency.notAble ? null : state.data.trainingTargets,
        flexible: event.data == PhysicalActivitiesFrequency.notAble ? null : state.data.flexible,
      ),
    ));
  }

  FutureOr<void> _onSetTargets(
    _SetTargets event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.preferencesLoaded(
      state.data.copyWith(
        trainingTargets: event.data,
      ),
    ));
  }

  FutureOr<void> _onSetFlexible(
    _SetFlexible event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.preferencesLoaded(
      state.data.copyWith(
        flexible: event.data,
      ),
    ));
  }

  FutureOr<void> _onGetPreferences(
    _GetPreferences event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final response = await _physicalActivitiesService.getPreferences();

    response.fold(
      (l) => emit(PhysicalActivitiesPreferencesState.error(
          state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        PhysicalActivitiesPreferencesState.preferencesLoaded(
          state.data.copyWith(
            trainingFrequency: PhysicalActivitiesFrequency.values
                .firstWhereOrNull((e) => e.apiValue == r.trainingFrequency),
            trainingTargets: PhysicalActivitiesType.values
                .firstWhereOrNull((e) => e.apiValue == r.trainingTargets),
            flexible: r.flexible ?? false,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSavePreferences(
    _SavePreferences event,
    Emitter<PhysicalActivitiesPreferencesState> emit,
  ) async {
    emit(PhysicalActivitiesPreferencesState.saving(
        state.data.copyWith(isLoading: true, error: null)));

    final response = await _physicalActivitiesService.setPreferences(
      PhysicalActivitiesPreferencesBody(
        trainingFrequency: state.data.trainingFrequency?.apiValue ?? '',
        trainingTargets: state.data.trainingTargets?.apiValue,
        flexible: state.data.flexible,
      ),
    );

    response.fold(
      (l) => emit(PhysicalActivitiesPreferencesState.error(
          state.data.copyWith(isLoading: false, error: l))),
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
