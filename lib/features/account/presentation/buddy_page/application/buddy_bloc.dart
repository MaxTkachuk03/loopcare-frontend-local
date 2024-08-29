import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/buddy/domain/request_buddy.dart';
import 'package:loopcare_frontend/features/buddy/infrastrucure/buddy_service.dart';

part 'buddy_bloc.freezed.dart';
part 'buddy_event.dart';
part 'buddy_state.dart';

@singleton
class BuddyBloc extends Bloc<BuddyEvent, BuddyState> {
  final BuddyService _buddyService;

  BuddyBloc(this._buddyService) : super(const BuddyState.initial(BuddyStateData())) {
    on<BuddyLiveTogether>(_onBuddyLiveTogether);
    on<BuddyRelation>(_onBuddyRelation);
    on<BuddyEmail>(_onBuddyEmail);
    on<InviteBuddy>(_onInviteBuddy);
    on<RemoveBuddy>(_onRemoveBuddy);
    on<RemoveInvitation>(_onRemoveInvitation);
    on<ResendInvitation>(_onResendInvitation);
    on<UpdateBuddyState>(_onUpdateBuddyState);
    on<UpdateBuddyStatus>(_onUpdateBuddyStatus);
  }

  FutureOr<void> _onUpdateBuddyState(
    UpdateBuddyState event,
    Emitter<BuddyState> emit,
  ) async {
    final buddyState = switch (event.data?.buddyState) {
      BuddyStatus.invited => BuddyState.invited,
      BuddyStatus.rejected => BuddyState.rejected,
      BuddyStatus.approved => BuddyState.approved,
      BuddyStatus.left => BuddyState.left,
      _ => BuddyState.gotBuddy,
    };

    emit(
      buddyState(state.data.copyWith(
        isLoading: false,
        buddyState: event.data?.buddyState,
        buddy: event.data?.buddy,
        liveTogether: event.data?.buddy?.invitation?.liveTogether,
        relation: event.data?.buddy?.invitation?.relation,
        email: event.data?.buddy?.email,
      )),
    );
  }

  FutureOr<void> _onUpdateBuddyStatus(
    UpdateBuddyStatus event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.gotBuddy(state.data.copyWith(buddyState: event.status)));
  }

  FutureOr<void> _onRemoveBuddy(
    RemoveBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));

    final response = await _buddyService.removeBuddy();

    response.fold(
      (l) => emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(BuddyState.initial(state.data.copyWith(isLoading: false))),
    );
  }

  FutureOr<void> _onResendInvitation(
    ResendInvitation event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));

    final response = await _buddyService.resendBuddy();

    response.fold(
      (l) => emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(BuddyState.gotBuddy(state.data.copyWith(isLoading: false))),
    );
  }

  FutureOr<void> _onInviteBuddy(
    InviteBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));

    if (!state.data.gotAllNecessaryData) return;

    final response = await _buddyService.inviteBuddy(RequestBuddy(
      liveTogether: state.data.liveTogether ?? false,
      relation: state.data.relation ?? '',
      email: state.data.email ?? '',
    ));

    response.fold(
      (l) => emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(BuddyState.gotBuddy(state.data.copyWith(isLoading: false))),
    );
  }

  FutureOr<void> _onRemoveInvitation(
    RemoveInvitation event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));

    final response = await _buddyService.rejectInvitation();

    response.fold(
      (l) => emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(BuddyState.gotBuddy(state.data.copyWith(isLoading: false))),
    );
  }

  FutureOr<void> _onBuddyLiveTogether(
    BuddyLiveTogether event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.gotBuddy(state.data.copyWith(liveTogether: event.liveTogether)));
  }

  FutureOr<void> _onBuddyRelation(
    BuddyRelation event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.gotBuddy(state.data.copyWith(relation: event.relation)));
  }

  FutureOr<void> _onBuddyEmail(
    BuddyEmail event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.gotBuddy(state.data.copyWith(email: event.email)));
  }
}
