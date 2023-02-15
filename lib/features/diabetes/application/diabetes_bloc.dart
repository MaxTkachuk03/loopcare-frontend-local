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
    // on<SaveDiabetesType>(_onSaveDiabetesType);
    // on<SetDiabetesType>(_onSetDiabetesType);
  }

  FutureOr<void> _onFetchDiabetesTypes(
    FetchDiabetesTypes event,
    Emitter<DiabetesState> emit,
  ) async {
    // emit(
    //   state.copyWith(
    //       diabetesTypes: [
    //     DiabetesType(id: 0, name: 'type I'),
    //     DiabetesType(id: 1, name: 'type II'),
    //     DiabetesType(id: 2, name: 'no'),
    //   ].toIList()),
    // );
    //
    final response = await diabetesService.diabetesTypes();

    response.fold(
      (l) => null,
      (r) {
        print(r);
        emit(
          state.copyWith(diabetesTypes: r.data.toIList()),
        );
      },
    );
  }
}
