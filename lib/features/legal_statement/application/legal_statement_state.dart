part of 'legal_statement_bloc.dart';

@freezed
class LegalStatementState with _$LegalStatementState {
  factory LegalStatementState.initial() => const LegalStatementState();

  const factory LegalStatementState({
    @Default(false) bool pageWasPassed,
  }) = _LegalStatementState;

  factory LegalStatementState.fromJson(Map<String, dynamic> json) =>
      _$LegalStatementStateFromJson(json);
}
