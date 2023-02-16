import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_service.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';

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
    // TODO send request to save selected diabetes type on the server
    emit(state.copyWith(isCompleted: true));
  }

  FutureOr<void> _onSetDiabetesType(
    SetDiabetesType event,
    Emitter<DiabetesState> emit,
  ) async {
    emit(state.copyWith(selectedType: event.selectedType));
  }
}
