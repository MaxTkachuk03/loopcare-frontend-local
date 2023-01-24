import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_validation_errors.freezed.dart';

@freezed
abstract class NameValidationErrors with _$NameValidationErrors {
  const factory NameValidationErrors.empty() = _Empty;
}
