part of 'user_states_bloc.dart';

@freezed
class UserStatesEvent with _$UserStatesEvent {
  const factory UserStatesEvent.updateBuddyStatus() = UpdateBuddyStatusEvent;

  const factory UserStatesEvent.hideBuddyBadge() = HideBuddyBadgeEvent;
}
