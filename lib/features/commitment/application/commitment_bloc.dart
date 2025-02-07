import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/commitment/domain/commitment_service.dart';

part 'commitment_bloc.freezed.dart';

part 'commitment_event.dart';

part 'commitment_state.dart';

@singleton
class CommitmentBloc extends Bloc<CommitmentEvent, CommitmentState> {
  final CommitmentService _commitmentService;

  CommitmentBloc(this._commitmentService)
      : super(const CommitmentState.initial(CommitmentStateData())) {
    on<GetCommitment>(_onGetCommitment);
    on<UpdateCommitment>(_onUpdateCommitment);
    on<ResetCommitment>(_onResetCommitment);
  }

  FutureOr<void> _onGetCommitment(
    GetCommitment event,
    Emitter<CommitmentState> emit,
  ) async {
    emit(const CommitmentState.initial(CommitmentStateData()));
    emit(CommitmentState.loading(state.data.copyWith(isLoading: true)));

    final response = await _commitmentService.getCommitment(date: event.date);

    response.fold(
      (l) => emit(CommitmentState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(CommitmentState.commitmentLoaded(state.data.copyWith(
          totalCommitments: r.totalCommitments,
          completedCommitments: r.completedCommitments,
          isCommitmentUnlocked: r.isCommitmentUnlocked,
          showCommitmentWidget: r.showCommitmentWidget,
          isLoading: false))),
    );
  }

  FutureOr<void> _onUpdateCommitment(
    UpdateCommitment event,
    Emitter<CommitmentState> emit,
  ) async {
    final previousCompleted = state.data.completedCommitments;
    emit(CommitmentState.commitmentLoaded(state.data.copyWith(
      completedCommitments: previousCompleted + 1,
    )));
  }

  FutureOr<void> _onResetCommitment(
    ResetCommitment event,
    Emitter<CommitmentState> emit,
  ) async {
    emit(CommitmentState.commitmentLoaded(state.data.copyWith(
        totalCommitments: 0,
        completedCommitments: 0,
        isCommitmentUnlocked: false,
        showCommitmentWidget: true,
        isLoading: false)));
  }
}
