part of 'consent_confirmation_bloc.dart';

@freezed
class ConsentConfirmationEvent with _$ConsentConfirmationEvent {
  const factory ConsentConfirmationEvent.passageChanged(bool value) = PassageChanged;
}
