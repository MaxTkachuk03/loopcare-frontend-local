import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_analytics_event_response.g.dart';

@immutable
@JsonSerializable()
class SendAnalyticsEventResponse {
  final String event;
  final int accountId;
  final int? groupId;
  final String platform;
  final Map<String, String> metadata;

  const SendAnalyticsEventResponse({
    required this.event,
    required this.accountId,
    required this.groupId,
    required this.platform,
    required this.metadata,
  });

  static SendAnalyticsEventResponse fromJson(Map<String, dynamic> json) =>
      _$SendAnalyticsEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendAnalyticsEventResponseToJson(this);
}
