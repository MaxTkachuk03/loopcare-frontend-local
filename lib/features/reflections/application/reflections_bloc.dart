import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/submit_reflection_body.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_service.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

part 'reflections_event.dart';
part 'reflections_state.dart';
part 'reflections_bloc.freezed.dart';

@singleton
class ReflectionsBloc extends Bloc<ReflectionsEvent, ReflectionsState> {
  final ReflectionsService _reflectionsService;

  ReflectionsBloc(this._reflectionsService)
      : super(const ReflectionsState.initial(ReflectionsStateData())) {
    on<GetReflections>(_onGetReflections);
    on<SetActiveReflection>(_onSetActiveReflection);
    on<ResetActiveReflection>(_onResetActiveReflection);
    on<UpdateReflectionAnswer>(_onUpdateReflectionAnswer);
    on<SaveReflectionAnswer>(_onSaveReflectionAnswer);
  }

  FutureOr<void> _onGetReflections(
    GetReflections event,
    Emitter<ReflectionsState> emit,
  ) async {
    emit(ReflectionsState.loading(state.data.copyWith(isLoading: true)));

    final res = await _reflectionsService.getReflections();

    res.fold(
      (l) => emit(ReflectionsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(ReflectionsState.reflectionsLoaded(
        state.data.copyWith(reflections: r.data, isLoading: false),
      )),
    );
  }

  FutureOr<void> _onSetActiveReflection(
    SetActiveReflection event,
    Emitter<ReflectionsState> emit,
  ) async {
    emit(ReflectionsState.reflectionsLoaded(
        state.data.copyWith(activeReflection: event.reflection)));
  }

  FutureOr<void> _onResetActiveReflection(
    ResetActiveReflection event,
    Emitter<ReflectionsState> emit,
  ) async {
    emit(ReflectionsState.reflectionsLoaded(state.data.copyWith(activeReflection: null)));
  }

  FutureOr<void> _onSaveReflectionAnswer(
    SaveReflectionAnswer event,
    Emitter<ReflectionsState> emit,
  ) async {
    final activeReflection = state.data.activeReflection;

    if (activeReflection == null) return;

    emit(ReflectionsState.loading(state.data.copyWith(isLoading: true)));

    final res = await _reflectionsService.saveReflectionAnswer(
        reflectionId: activeReflection.id, data: event.data);

    _updateReflection(emit, res);
  }

  FutureOr<void> _onUpdateReflectionAnswer(
    UpdateReflectionAnswer event,
    Emitter<ReflectionsState> emit,
  ) async {
    final activeReflection = state.data.activeReflection;

    if (activeReflection == null) return;

    emit(ReflectionsState.loading(state.data.copyWith(isLoading: true)));

    final res = await _reflectionsService.updateReflectionAnswer(
        reflectionId: activeReflection.id, data: event.data);

    _updateReflection(emit, res);
  }

  void _updateReflection(Emitter<ReflectionsState> emit, Either<RequestError, Reflection> res) {
    res.fold(
      (l) => emit(ReflectionsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(ReflectionsState.reflectionsLoaded(
          state.data.copyWith(
            reflections: state.data.reflections.map((ref) => ref.id == r.id ? r : ref).toList(),
            activeReflection: r,
            isLoading: false,
          ),
        ));
      },
    );
  }
}
