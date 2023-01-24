import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_validation_errors.freezed.dart';

@freezed
abstract class EmailValidationErrors with _$EmailValidationErrors {
  const factory EmailValidationErrors.empty() = _Empty;

  const factory EmailValidationErrors.invalid() = _Invalid;
}
