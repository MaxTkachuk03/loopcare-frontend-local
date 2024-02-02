import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_code_validation_errors.freezed.dart';

@freezed
abstract class RegistrationCodeValidationErrors with _$RegistrationCodeValidationErrors {
  const factory RegistrationCodeValidationErrors.empty() = _EmptyCode;

  const factory RegistrationCodeValidationErrors.invalid() = _InvalidCode;
}
