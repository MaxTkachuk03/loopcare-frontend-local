part of 'user_states_bloc.dart';

@freezed
class UserStatesState with _$UserStatesState {
  const UserStatesState._();

  const factory UserStatesState.init(UserStatesData data) = InitialUserStatesState;

  const factory UserStatesState.statesUpdated(UserStatesData data) = UserStatesStateIsLoading;
}

@freezed
class UserStatesData with _$UserStatesData {
  const UserStatesData._();

  const factory UserStatesData({
    @Default({}) Map<int, UserStatesModel> statesMap,
  }) = _UserStatesData;

  factory UserStatesData.fromJson(Map<String, dynamic> json) => _$UserStatesDataFromJson(json);

  bool showBuddyBadgeForUser(int? id) => id != null && (statesMap[id]?.showBuddyBadge ?? false);
}
