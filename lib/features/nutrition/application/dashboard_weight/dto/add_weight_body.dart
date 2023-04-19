import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_weight_body.freezed.dart';

part 'add_weight_body.g.dart';

@freezed
abstract class AddWeightBody implements _$AddWeightBody {
  const AddWeightBody._();

  const factory AddWeightBody({
    required double weight,
    required String date,
  }) = _AddWeightBody;

  factory AddWeightBody.fromJson(Map<String, dynamic> json) =>
      _$AddWeightBodyFromJson(json);
}
