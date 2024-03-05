import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/buddy/infrastrucure/buddy_service.dart';

part 'buddy_bloc.freezed.dart';
part 'buddy_event.dart';
part 'buddy_state.dart';

class BuddyBloc extends Bloc<BuddyEvent, BuddyState> {
  final AuthenticationService _authenticationService;
  final BuddyService _buddyService;

  BuddyBloc(this._authenticationService, this._buddyService) : super(const BuddyState.initial(BuddyStateData())) {
    on<InitBuddy>(_onInitBuddy);
  }

  FutureOr<void> _onInitBuddy(
    InitBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(const BuddyState.initial(BuddyStateData()));
  }
}
