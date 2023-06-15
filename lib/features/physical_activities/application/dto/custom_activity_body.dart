import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_activity_body.freezed.dart';

part 'custom_activity_body.g.dart';

@freezed
abstract class CustomActivityBody implements _$CustomActivityBody {
  const CustomActivityBody._();

  const factory CustomActivityBody({
    required String name,
  }) = _CustomActivityBody;

  factory CustomActivityBody.fromJson(Map<String, dynamic> json) =>
      _$CustomActivityBodyFromJson(json);
}
