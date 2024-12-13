import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error_data.freezed.dart';
part 'server_error_data.g.dart';

@freezed
class ServerErrorData with _$ServerErrorData {
  const factory ServerErrorData({
    String? error,
    @ServerErrorMessageConverter() String? message,
    int? statusCode,
  }) = _ServerErrorData;

  factory ServerErrorData.fromJson(Map<String, dynamic> json) => _$ServerErrorDataFromJson(json);
}

class ServerErrorMessageConverter implements JsonConverter<String, dynamic> {
  const ServerErrorMessageConverter();

  @override
  String fromJson(dynamic message) =>
      message.runtimeType == List ? (message as List).join(', ') : message;

  @override
  String toJson(String object) => object.toString();
}
