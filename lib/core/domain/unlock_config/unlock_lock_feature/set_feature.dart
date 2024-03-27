import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/feature/feature.dart';

part 'set_feature.freezed.dart';
part 'set_feature.g.dart';

@freezed
abstract class SetFeature implements _$SetFeature {
  const SetFeature._();

  const factory SetFeature({
    required int accountId,
    required Feature feature,
  }) = _SetFeature;

  factory SetFeature.fromJson(Map<String, dynamic> json) => _$SetFeatureFromJson(json);
}
