import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_info_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_unlock_style.dart';
import 'package:loopcare_frontend/features/mind/application/mind_service.dart';

part 'mind_bloc.freezed.dart';
part 'mind_event.dart';
part 'mind_state.dart';

@singleton
class MindBloc extends Bloc<MindEvent, MindState> {
  final MindService _mindService;

  MindBloc(this._mindService) : super(const MindState.initial(MindStateData())) {
    on<GetTechniques>(_onGetTechniques);
    on<GetExercises>(_onGetExercises);
    on<CompleteCurrentExercise>(_onCompleteCurrentExercise);
    on<UnlockNextExercise>(_onUnlockNextExercise);
    on<SelectExercise>(_onSelectExercise);
  }

  FutureOr<void> _onGetTechniques(GetTechniques event, Emitter<MindState> emit) async {
    emit(MindState.loading(state.data.copyWith(isLoading: true)));

    final responseInfo = await _mindService.getMindInfo();

    final responseTechniques = await _mindService.getTechniques();

    if (responseTechniques.isLeft() || responseInfo.isLeft()) {
      responseTechniques.fold(
        (l) => emit(MindState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) => null,
      );

      responseInfo.fold(
        (l) => emit(MindState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) => null,
      );
    } else {
      emit(
        MindState.gotTechniques(
          state.data.copyWith(
            mindInfo: responseInfo.foldRight(null, (r, _) => r),
            techniques: responseTechniques.foldRight([], (r, _) => r.data),
            isLoading: false,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onGetExercises(GetExercises event, Emitter<MindState> emit) async {
    emit(
      MindState.loading(
        state.data.copyWith(
          currentTechnique: state.data.techniques.firstWhere((technique) => technique.id == event.techniqueId),
          isLoading: true,
        ),
      ),
    );

    final response = await _mindService.getTechniquesExercises(event.techniqueId);

    response.fold(
      (l) => emit(MindState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
          MindState.gotExercises(
            state.data.copyWith(
              exercises: r.data,
              isLoading: false,
            ),
          ),
        ),
    );
  }

  FutureOr<void> _onCompleteCurrentExercise(
    CompleteCurrentExercise event,
    Emitter<MindState> emit,
  ) async {
    final techniqueId = state.data.currentTechnique?.id;
    final exerciseId = state.data.currentExercise?.id;

    if (techniqueId == null || exerciseId == null ||
        state.data.currentExercise?.completedAt != null) {
      return;
    }

    final response = await _mindService.completeExercise(techniqueId, exerciseId);

    response.fold(
      (l) => emit(MindState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        AnalyticsEventService.instance.logEvent(
          FirebaseEvents.mindCompletedExercise,
          parameters: {
            CustomDefinitions.techniqueId: techniqueId,
            CustomDefinitions.exerciseId: exerciseId,
            CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
          },
        );

        CustomerIoService.track(
          event: CIOEvents.mindCompletedExercise,
          attributes: {
            CIOAttributes.techniqueId: techniqueId,
            CIOAttributes.exerciseId: exerciseId,
          },
        );

        if (!state.data.isLastExercise && state.data.isConsecutiveUnlock) {
          add(MindEvent.unlockNextExercise(exerciseId: state.data.nextExercise.id));
        }

        // todo update model
        emit(
          MindState.exerciseCompleted(
            state.data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUnlockNextExercise(
    UnlockNextExercise event,
    Emitter<MindState> emit,
  ) async {
    final exercises = state.data.exercises
        .map((e) => e.id == event.exerciseId ? e.copyWith(isLocked: false) : e)
        .toList();

    emit(
      MindState.exerciseUnlocked(
        state.data.copyWith(
          exercises: exercises,
        ),
      ),
    );
  }

  FutureOr<void> _onSelectExercise(
    SelectExercise event,
    Emitter<MindState> emit,
  ) async {
    emit(
      MindState.exerciseSelected(
        state.data.copyWith(
          currentExercise: event.exercise,
        ),
      ),
    );
  }
}
