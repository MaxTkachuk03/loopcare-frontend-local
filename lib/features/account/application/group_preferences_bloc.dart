import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_body.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_service.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';

part 'group_preferences_event.dart';
part 'group_preferences_state.dart';
part 'group_preferences_bloc.freezed.dart';

@singleton
class GroupPreferencesBloc extends Bloc<GroupPreferencesEvent, GroupPreferencesState> {
  final GroupPreferencesService _groupPreferencesService;

  GroupPreferencesBloc(this._groupPreferencesService)
      : super(const GroupPreferencesState.initial(GroupPreferencesData())) {
    on<SetGenderPreferences>(_onSetGenderPreferences);
    on<SetTimezone>(_onSetTimezone);
    on<SetNickname>(_onSetNickname);
  }

  FutureOr<void> _onSetGenderPreferences(
    SetGenderPreferences event,
    Emitter<GroupPreferencesState> emit,
  ) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final data = GroupPreferencesBody(genderPreference: event.gender);

    final response = await _groupPreferencesService.savePreferences(data);

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(GroupPreferencesState.updated(state.data.copyWith(
        genderPreferences: r.genderPreference,
        isLoading: false,
        error: null,
      ))),
    );
  }

  FutureOr<void> _onSetTimezone(
    SetTimezone event,
    Emitter<GroupPreferencesState> emit,
  ) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final data = GroupPreferencesBody(timezone: event.timezone);

    final response = await _groupPreferencesService.savePreferences(data);

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(GroupPreferencesState.updated(state.data.copyWith(
        timezone: r.timezone,
        isLoading: false,
        error: null,
      ))),
    );
  }

  FutureOr<void> _onSetNickname(
    SetNickname event,
    Emitter<GroupPreferencesState> emit,
  ) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final data = GroupPreferencesBody(nickname: event.nickname);

    final response = await _groupPreferencesService.savePreferences(data);

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(GroupPreferencesState.updated(state.data.copyWith(
        nickname: r.nickname,
        isLoading: false,
        error: null,
      ))),
    );
  }
}
