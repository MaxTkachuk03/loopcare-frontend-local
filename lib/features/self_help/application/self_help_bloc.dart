import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/prefer_gender.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/update_account_prefer_gender.dart';
import 'package:loopcare_frontend/features/self_help/application/account_prefer_gender_service.dart';

part 'self_help_bloc.freezed.dart';

part 'self_help_bloc.g.dart';

part 'self_help_event.dart';

part 'self_help_state.dart';

part 'self_help_questions.dart';

@singleton
class SelfHelpBloc extends HydratedBloc<SelfHelpEvent, SelfHelpState> {
  final AccountPreferGenderService accountPreferGenderService;

  SelfHelpBloc(this.accountPreferGenderService) : super(SelfHelpState.initial()) {
    on<SetAccountPreferGender>(_onSetPreferGender);
    on<GetAccountPreferGender>(_onGetPreferGender);
    on<SaveAccountPreferGender>(_onSavePreferGender);
    on<FetchPreferGendersTypes>(_onFetchPreferGendersTypes);
  }

  FutureOr<void> _onFetchPreferGendersTypes(
    FetchPreferGendersTypes event,
    Emitter<SelfHelpState> emit,
  ) async {
    final response = await accountPreferGenderService.getAllPreferGenderTypes();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(
          preferedGenderTypes: r.data.toIList(),
        ),
      ),
    );
  }

  FutureOr<void> _onSavePreferGender(
    SaveAccountPreferGender event,
    Emitter<SelfHelpState> emit,
  ) async {
    final id = state.selectedType?.id;

    if (id == null) return;

    final data = UpdateAccountPreferGender(id: id);

    final response = await accountPreferGenderService.savePreferGender(data);

    response.fold(
      (l) => emit(
        state.copyWith(isCompleted: false),
      ),
      (r) => emit(
        state.copyWith(isCompleted: true),
      ),
    );
  }

  FutureOr<void> _onSetPreferGender(
    SetAccountPreferGender event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(
      state.copyWith(
        selectedType: event.preferGender,
      ),
    );
  }

  Future<FutureOr<void>> _onGetPreferGender(
    GetAccountPreferGender event,
    Emitter<SelfHelpState> emit,
  ) async {
    final response = await accountPreferGenderService.getAccountPreferGenderType();

    response.fold(
      (l) => emit(
        state.copyWith(isCompleted: false),
      ),
      (r) => emit(
        state.copyWith(
          selectedType: PreferGender(id: r.id, name: r.name),
          isCompleted: true,
        ),
      ),
    );
  }

  @override
  SelfHelpState? fromJson(Map<String, dynamic> json) =>
      SelfHelpState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SelfHelpState state) {
    return state.toJson();
  }
}
