import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/features/mind/application/dto/complete_exercise_data.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_info_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_techniques_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_unlock_style.dart';
import 'package:loopcare_frontend/features/mind/application/mind_service.dart';
import 'package:loopcare_frontend/features/mind/application/ui_models/mind_exercise_step.dart';

part 'mind_bloc.freezed.dart';
part 'mind_event.dart';
part 'mind_state.dart';

@singleton
class MindBloc extends Bloc<MindEvent, MindState> {
  final MindService _mindService;

  MindBloc(this._mindService) : super(const MindState.initial(MindStateData())) {
    on<InitMind>(_onInitMind);
    on<GetTechniques>(_onGetTechniques);
    on<GetExercises>(_onGetExercises);
    on<CompleteCurrentExercise>(_onCompleteCurrentExercise);
    on<UnlockNextExercise>(_onUnlockNextExercise);
    on<SelectExercise>(_onSelectExercise);
    on<AddRating>(_onAddRating);
  }

  FutureOr<void> _onInitMind(InitMind event, Emitter<MindState> emit) async {
    emit(const MindState.initial(MindStateData()));
  }

  FutureOr<void> _onGetTechniques(GetTechniques event, Emitter<MindState> emit) async {
    emit(MindState.loading(state.data.copyWith(isLoading: true)));

    final responses = await Future.wait([
      _mindService.getMindInfo(),
      _mindService.getTechniques(),
    ]);

    final failedResponses = responses.where((response) => response.isLeft());

    if (failedResponses.isNotEmpty) {
      failedResponses.first.fold(
            (l) => emit(MindState.error(state.data.copyWith(error: l, isLoading: false))),
            (r) => null,
          );
    } else {
      emit(
        MindState.gotTechniques(
          state.data.copyWith(
            mindInfo: responses.first.foldRight(null, (r, _) => r as MindInfoResponse),
            techniques: responses.last.foldRight([], (r, _) => (r as MindTechniquesResponse).data),
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
    final data = CompleteExerciseData(
      scaleBeforeAnswer: state.data.scaleBeforeAnswer,
      scaleAfterAnswer: state.data.scaleAfterAnswer,
    );

    if (techniqueId == null || exerciseId == null) {
      return;
    }

    final response = await _mindService.completeExercise(techniqueId, exerciseId, data: data);

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

        if (!state.data.isLastExercise && state.data.isConsecutiveUnlock) {
          add(MindEvent.unlockNextExercise(exerciseId: state.data.nextExercise.id));
        }

        final updatedExercise = state.data.currentExercise!.copyWith(completedAt: r.completedAt);

        final exercises = state.data.exercises
            .map((e) => e.id == exerciseId ? updatedExercise : e)
            .toList();

        emit(
          MindState.exerciseCompleted(
            state.data.copyWith(
              currentExercise: updatedExercise,
              exercises: exercises,
            ),
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
        MindStateData(
          currentExercise: event.exercise,
          currentTechnique: state.data.currentTechnique,
          exercises: state.data.exercises,
          mindInfo: state.data.mindInfo,
          techniques: state.data.techniques,
        ),
      ),
    );
  }

  FutureOr<void> _onAddRating(
    AddRating event,
    Emitter<MindState> emit,
  ) async {
    final scaleAfterAnswer = event.isAfter ? event.value : state.data.scaleAfterAnswer;
    final scaleBeforeAnswer = !event.isAfter ? event.value : state.data.scaleBeforeAnswer;
    final logEventName = event.isAfter ? FirebaseEvents.mindRatingAfterExercise : FirebaseEvents.mindRatingBeforeExercise;

    AnalyticsEventService.instance.logEvent(
      logEventName,
      parameters: {
        CustomDefinitions.techniqueId: state.data.currentTechnique?.id ?? 0,
        CustomDefinitions.exerciseId: state.data.currentExercise?.id ?? 0,
        CustomDefinitions.value: event.value,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );

    CustomerIoService.track(
      event: logEventName,
      attributes: {
        CustomDefinitions.techniqueId: state.data.currentTechnique?.id ?? 0,
        CustomDefinitions.exerciseId: state.data.currentExercise?.id ?? 0,
        CustomDefinitions.value: event.value,
      }
    );

    emit(
      MindState.exerciseSelected(
        state.data.copyWith(
          scaleAfterAnswer: scaleAfterAnswer,
          scaleBeforeAnswer: scaleBeforeAnswer,
        ),
      ),
    );
  }
}
