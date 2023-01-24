import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_password_validation_errors.freezed.dart';

@freezed
abstract class LoginPasswordValidationErrors with _$LoginPasswordValidationErrors {
  const factory LoginPasswordValidationErrors.empty() = _Empty;
}
