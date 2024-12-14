import 'package:freezed_annotation/freezed_annotation.dart';

part 'height_validation_errors.freezed.dart';

@freezed
abstract class HeightValidationErrors with _$HeightValidationErrors {
  const factory HeightValidationErrors.empty() = _Empty;
  const factory HeightValidationErrors.heightTooLarge() = _HeightTooLarge;
  const factory HeightValidationErrors.heightTooSmall() = _HeightTooSmall;
}
