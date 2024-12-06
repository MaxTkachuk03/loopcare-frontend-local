import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_done_lessons/nutrition_intake_done_lessons.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/domain/nutrution_intake_services.dart';

part 'nutrution_intake_event.dart';
part 'nutrution_intake_state.dart';
part 'nutrution_intake_bloc.freezed.dart';

@singleton
class NutrutionIntakeBloc
    extends Bloc<NutrutionIntakeEvent, NutrutionIntakeState> {
  final NutrutionIntakeServices _nutrutionIntakeServices;

  NutrutionIntakeBloc(this._nutrutionIntakeServices)
      : super(const NutrutionIntakeState.initial(NutrutionIntakeStateData())) {
    on<FetchProgress>(_onGetProgress);
    on<CloseDay>(_closeDay);
  }

  Future<void> _onGetProgress(
    FetchProgress event,
    Emitter<NutrutionIntakeState> emit,
  ) async {
    emit(NutrutionIntakeState.loading(state.data.copyWith(isLoading: true)));

    final response =
        await _nutrutionIntakeServices.getLessons(date: event.date);

    response.fold(
        (left) => emit(NutrutionIntakeState.error(
            state.data.copyWith(error: left, isLoading: false))),
        (right) => emit(NutrutionIntakeState.loaded(state.data.copyWith(
            isDayClosed: right.isDayClosed,
            progress: right.progress,
            isLoading: false))));
  }

  Future<void> _closeDay(
    CloseDay event,
    Emitter<NutrutionIntakeState> emit,
  ) async {
    await _nutrutionIntakeServices.closeDay(isDayClosed: event.isDayClosed);

    emit(NutrutionIntakeState.closeDay(
        state.data.copyWith(isDayClosed: event.isDayClosed)));
  }
}
