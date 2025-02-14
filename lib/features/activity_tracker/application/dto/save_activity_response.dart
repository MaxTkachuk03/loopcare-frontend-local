import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_activity_response.g.dart';

@immutable
@JsonSerializable()
class SaveActivityResponse {
  final List<Map<String, dynamic>> activityData;

  const SaveActivityResponse([this.activityData = const []]);

  static SaveActivityResponse fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return const SaveActivityResponse();
    }
    return _$SaveActivityResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SaveActivityResponseToJson(this);
}
