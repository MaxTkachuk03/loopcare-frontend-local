part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.initial(BuddyStateData data) = InitialBuddyState;

  const factory BuddyState.loading(BuddyStateData data) = LoadingBuddyState;

  const factory BuddyState.error(BuddyStateData data) = ErrorBuddyState;

  const factory BuddyState.noBuddy(BuddyStateData data) = NoBuddy;
}

@freezed
class BuddyStateData with _$BuddyStateData {
  const BuddyStateData._();

  const factory BuddyStateData({
    RequestError? error,
    @Default(false) bool isLoading,
    Buddy? buddy,
  }) = _BuddyStateData;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.error, orElse: () => null);

  bool get hasBuddy => buddy?.isActive ?? false;
}
