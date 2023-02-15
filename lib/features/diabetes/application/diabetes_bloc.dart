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

@injectable
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
    emit(
      state.copyWith(
          diabetesTypes: [
        DiabetesType(id: 1, name: 'Test1'),
        DiabetesType(id: 2, name: 'Test2'),
        DiabetesType(id: 3, name: 'Test3'),
      ].toIList()),
    );
  }
}
