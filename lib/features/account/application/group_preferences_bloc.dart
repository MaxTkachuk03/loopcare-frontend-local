import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_body.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_service.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/gender_preferences.dart';

part 'group_preferences_bloc.freezed.dart';
part 'group_preferences_event.dart';
part 'group_preferences_state.dart';

@singleton
class GroupPreferencesBloc extends Bloc<GroupPreferencesEvent, GroupPreferencesState> {
  final GroupPreferencesService _groupPreferencesService;
  final AuthenticationCubit _authBloc;

  GroupPreferencesBloc(this._groupPreferencesService, this._authBloc)
      : super(const GroupPreferencesState.initial(GroupPreferencesData())) {
    on<SetGenderPreferences>(_onSetGenderPreferences);
    on<InitClear>(_onSetInitClear);
    on<SetInitialData>(_onSetInitialData);
    on<SetWouldLikeJoinGroup>(_onSetWouldLikeJoinGroup);
    on<SetTimezone>(_onSetTimezone);
    on<SetNickname>(_onSetNickname);
    on<LeaveGroup>(_onLeaveGroup);
    on<CancelGrouping>(_onCancelGrouping);
    on<ChangeGroupPrefsMode>(_onChangeGroupPrefsMode);
    on<AcceptRules>(_onAcceptRules);
  }

  FutureOr<void> _onSetInitClear(InitClear event, Emitter<GroupPreferencesState> emit) {
    emit(const GroupPreferencesState.initial(GroupPreferencesData()));
  }

  FutureOr<void> _onSetInitialData(
    SetInitialData event,
    Emitter<GroupPreferencesState> emit,
  ) {
    emit(GroupPreferencesState.updated(state.data.copyWith(
      isLoading: false,
      timezone: event.timezone,
      nickname: event.nickname,
      genderPreferences: event.gender,
      wouldLikeJoinGroup: event.value,
    )));
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
        genderPreferences: r.genderPreference ?? state.data.genderPreferences,
        isLoading: false,
        error: null,
      ))),
    );
  }

  FutureOr<void> _onSetWouldLikeJoinGroup(
    SetWouldLikeJoinGroup event,
    Emitter<GroupPreferencesState> emit,
  ) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    emit(
      GroupPreferencesState.updated(state.data.copyWith(wouldLikeJoinGroup: event.value, isLoading: false)),
    );
  }

  FutureOr<void> _onSetTimezone(
    SetTimezone event,
    Emitter<GroupPreferencesState> emit,
  ) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final data = _authBloc.state.isMixedGender
        ? GroupPreferencesBody(timezone: event.timezone, genderPreference: GenderPreferences.mixed)
        : GroupPreferencesBody(timezone: event.timezone);

    final response = await _groupPreferencesService.savePreferences(data);

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(GroupPreferencesState.updated(state.data.copyWith(
        timezone: r.timezone ?? state.data.timezone,
        genderPreferences: r.genderPreference ?? state.data.genderPreferences,
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
        nickname: r.nickname ?? state.data.nickname,
        isLoading: false,
        error: null,
      ))),
    );
  }

  FutureOr<void> _onLeaveGroup(LeaveGroup event, Emitter<GroupPreferencesState> emit) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final response = await _groupPreferencesService.leaveGroup();

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        _authBloc.changeAccountGroupStatus(r.groupingState);
        emit(GroupPreferencesState.updated(state.data.copyWith(
          nickname: '',
          timezone: '',
          wouldLikeJoinGroup: YesNoAnswer.no,
          genderPreferences: GenderPreferences.noPreference,
          isLoading: false,
          error: null,
        )));
      },
    );
  }

  FutureOr<void> _onCancelGrouping(CancelGrouping event, Emitter<GroupPreferencesState> emit) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final response = await _groupPreferencesService.cancelGroupingProcess();

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        _authBloc.changeAccountGroupStatus(r.groupingState);
        emit(GroupPreferencesState.updated(state.data.copyWith(
          nickname: '',
          timezone: '',
          wouldLikeJoinGroup: YesNoAnswer.no,
          genderPreferences: GenderPreferences.noPreference,
          isLoading: false,
          error: null,
        )));
      },
    );
  }

  FutureOr<void> _onChangeGroupPrefsMode(ChangeGroupPrefsMode event, Emitter<GroupPreferencesState> emit) {
    emit(GroupPreferencesState.updated(state.data.copyWith(
      groupPrefsMode: event.groupPrefsMode,
    )));
  }

  FutureOr<void> _onAcceptRules(event, Emitter<GroupPreferencesState> emit) async {
    emit(GroupPreferencesState.loading(state.data.copyWith(isLoading: true)));

    final response =
        await _groupPreferencesService.savePreferences(const GroupPreferencesBody(rulesAccepted: true));

    response.fold(
      (l) => emit(GroupPreferencesState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        _authBloc.getAccount();
        emit(GroupPreferencesState.updated(state.data.copyWith(
          isLoading: false,
          error: null,
        )));
      },
    );
  }
}
