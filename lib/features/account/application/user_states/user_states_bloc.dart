import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/features/account/domain/user_states_model/user_states_model.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';

part 'user_states_bloc.freezed.dart';
part 'user_states_bloc.g.dart';
part 'user_states_event.dart';
part 'user_states_state.dart';

@singleton
class UserStatesBloc extends HydratedBloc<UserStatesEvent, UserStatesState> {
  final AppSyncService _syncService;
  final SharedStorageService _storage;

  UserStatesBloc(
    this._syncService,
    this._storage,
  ) : super(const UserStatesState.init(UserStatesData())) {
    on<UpdateBuddyStatusEvent>(_onUpdateBuddyStatus);
    on<HideBuddyBadgeEvent>(_onHideBuddyBadge);

    _syncService.stream.listen(
      (event) => event.whenOrNull(
        updateBuddyStatus: () => add(const UserStatesEvent.updateBuddyStatus()),
      ),
    );
  }

  @override
  UserStatesState? fromJson(Map<String, dynamic> json) =>
      UserStatesState.statesUpdated(UserStatesData.fromJson(json));

  @override
  Map<String, dynamic>? toJson(UserStatesState state) => state.data.toJson();

  FutureOr<void> _onUpdateBuddyStatus(
    UpdateBuddyStatusEvent event,
    Emitter<UserStatesState> emit,
  ) async {
    final id = _storage.account?.id;

    if (id == null) return;

    var buddyState = state.data.statesMap[id]?.buddyStatus;
    final accountBuddyState = _storage.account?.buddyState;
    final showBuddyBadge = buddyState != accountBuddyState && !accountBuddyState.isInvited;

    if (showBuddyBadge) {
      _syncService.showProfileNotificationBadge();
    } else {
      buddyState = accountBuddyState;
    }

    final states = Map.of(state.data.statesMap)
      ..update(
        id,
        (value) => value.copyWith(buddyStatus: buddyState, showBuddyBadge: showBuddyBadge),
        ifAbsent: () => UserStatesModel(id: id, buddyStatus: buddyState),
      );

    emit(UserStatesState.statesUpdated(state.data.copyWith(statesMap: states)));
  }

  FutureOr<void> _onHideBuddyBadge(
    HideBuddyBadgeEvent event,
    Emitter<UserStatesState> emit,
  ) async {
    final id = _storage.account?.id;
    final buddyState = _storage.account?.buddyState;

    if (id == null) return;

    final states = Map.of(state.data.statesMap);
    states.update(
      id,
      (value) => value.copyWith(buddyStatus: buddyState, showBuddyBadge: false),
      ifAbsent: () => UserStatesModel(
        id: id,
        buddyStatus: buddyState,
        showBuddyBadge: false,
      ),
    );

    emit(UserStatesState.statesUpdated(state.data.copyWith(statesMap: states)));
  }
}
