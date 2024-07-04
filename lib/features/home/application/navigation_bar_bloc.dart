import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'navigation_bar_bloc.freezed.dart';
part 'navigation_bar_bloc.g.dart';
part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

@singleton
class NavigationBarBloc extends HydratedBloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(const NavigationBarState.initialised(NavigationBarStateData())) {
    on<InitNavigationBar>(_onInitNavigationBar);
    on<SetBeginningUncompleted>(_onSetBeginningUncompleted);
    on<UnlockPractise>(_onUnlockPractise);
    on<UnlockProfile>(_onUnlockProfile);
    on<CompleteBeginning>(_onCompleteBeginning);
    on<AddPractiseNotification>(_onAddPractiseNotification);
    on<RemovePractiseNotification>(_onRemovePractiseNotification);
    on<AddProfileNotification>(_onAddProfileNotification);
    on<RemoveProfileNotification>(_onRemoveProfileNotification);
  }

  @override
  NavigationBarState? fromJson(Map<String, dynamic> json) {
    final data = NavigationBarStateData.fromJson(json);

    if (!data.isPracticeOpen || !data.isProfileOpen) {
      return NavigationBarState.moduleOpened(data);
    } else if (!data.isBeginningCompleted) {
      return NavigationBarState.beginningUncompleted(data);
    } else {
      return NavigationBarState.initialised(data);
    }
  }

  @override
  Map<String, dynamic>? toJson(NavigationBarState state) => state.data.toJson();

  FutureOr<void> _onInitNavigationBar(
    InitNavigationBar event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(const NavigationBarState.initialised(NavigationBarStateData()));
  }

  FutureOr<void> _onUnlockPractise(
    UnlockPractise event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(isPracticeOpen: true)));
  }

  FutureOr<void> _onUnlockProfile(
    UnlockProfile event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(isProfileOpen: true)));
  }

  FutureOr<void> _onCompleteBeginning(
    CompleteBeginning event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(const NavigationBarState.initialised(NavigationBarStateData()));
  }

  FutureOr<void> _onSetBeginningUncompleted(
    SetBeginningUncompleted event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(
      NavigationBarState.beginningUncompleted(
        NavigationBarStateData(
          isBeginningCompleted: false,
          isPracticeOpen: event.isPracticeOpened,
          isProfileOpen: event.isProfileOpened,
        ),
      ),
    );
  }

  FutureOr<void> _onAddPractiseNotification(
    AddPractiseNotification event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(hasPracticeNotification: true)));
  }

  FutureOr<void> _onAddProfileNotification(
    AddProfileNotification event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(hasProfileNotification: true)));
  }

  FutureOr<void> _onRemovePractiseNotification(
    RemovePractiseNotification event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(hasPracticeNotification: false)));
  }

  FutureOr<void> _onRemoveProfileNotification(
    RemoveProfileNotification event,
    Emitter<NavigationBarState> emit,
  ) async {
    emit(NavigationBarState.moduleOpened(state.data.copyWith(hasProfileNotification: false)));
  }
}
