import 'package:freezed_annotation/freezed_annotation.dart';

part 'clone_dish_body.freezed.dart';

part 'clone_dish_body.g.dart';

@freezed
abstract class CloneDishBody implements _$CloneDishBody {
  const CloneDishBody._();

  const factory CloneDishBody({
    required int dishId,
  }) = _CloneDishBody;

  factory CloneDishBody.fromJson(Map<String, dynamic> json) => _$CloneDishBodyFromJson(json);
}
