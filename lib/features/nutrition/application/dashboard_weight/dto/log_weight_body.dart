import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_weight_body.freezed.dart';

part 'log_weight_body.g.dart';

@freezed
abstract class LogWeightBody implements _$LogWeightBody {
  const factory LogWeightBody({
    required String date,
    required double weight,
  }) = _LogWeightBody;
  const LogWeightBody._();

  factory LogWeightBody.fromJson(Map<String, dynamic> json) =>
      _$LogWeightBodyFromJson(json);
}
