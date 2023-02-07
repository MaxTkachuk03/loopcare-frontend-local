part of 'legal_statement_bloc.dart';

@freezed
class LegalStatementEvent with _$LegalStatementEvent {
  const factory LegalStatementEvent.passageChanged(bool value) = PassageChanged;
}
