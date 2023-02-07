part of 'consent_confirmation_bloc.dart';

@freezed
class ConsentConfirmationState with _$ConsentConfirmationState {
  factory ConsentConfirmationState.initial() =>
      const ConsentConfirmationState();

  const factory ConsentConfirmationState({
    @Default(false) bool pageWasPassed,
  }) = _ConsentConfirmationState;

  factory ConsentConfirmationState.fromJson(Map<String, dynamic> json) =>
      _$ConsentConfirmationStateFromJson(json);
}
