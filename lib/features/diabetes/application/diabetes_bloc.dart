import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_service.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/add_account_diabetes.dart';

part 'diabetes_bloc.freezed.dart';

part 'diabetes_event.dart';

part 'diabetes_state.dart';

@singleton
class DiabetesBloc extends Bloc<DiabetesEvent, DiabetesState> {
  final DiabetesService diabetesService;

  DiabetesBloc(this.diabetesService) : super(DiabetesState.initial()) {
    on<FetchDiabetesTypes>(_onFetchDiabetesTypes);
    on<SaveDiabetesType>(_onSaveDiabetesType);
    on<SetDiabetesType>(_onSetDiabetesType);
    on<GetAccountDiabetesType>(_onGetAccountDiabetesType);
  }

  FutureOr<void> _onFetchDiabetesTypes(
    FetchDiabetesTypes event,
    Emitter<DiabetesState> emit,
  ) async {
    final response = await diabetesService.diabetesTypes();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(diabetesTypes: r.data.toIList()),
      ),
    );
  }

  FutureOr<void> _onSaveDiabetesType(
    SaveDiabetesType event,
    Emitter<DiabetesState> emit,
  ) async {
    final id = state.selectedType?.id;

    if (id == null) return;

    final data = AddAccountDiabetes(id: id);

    final response = await diabetesService.saveDiabetesType(data);

    response.fold(
      (l) => emit(
        state.copyWith(isCompleted: false),
      ),
      (r) => emit(
        state.copyWith(isCompleted: true),
      ),
    );
  }

  FutureOr<void> _onGetAccountDiabetesType(
    GetAccountDiabetesType event,
    Emitter<DiabetesState> emit,
  ) async {
    final response = await diabetesService.getAccountDiabetesType();

    response.fold(
      (l) => emit(
        state.copyWith(isCompleted: false),
      ),
      (r) => emit(
        state.copyWith(
          selectedType: DiabetesType(id: r.id, name: r.name),
          isCompleted: true,
        ),
      ),
    );
  }

  FutureOr<void> _onSetDiabetesType(
    SetDiabetesType event,
    Emitter<DiabetesState> emit,
  ) async {
    emit(state.copyWith(selectedType: event.selectedType));
  }
}
