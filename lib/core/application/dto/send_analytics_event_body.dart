import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_analytics_event_body.freezed.dart';

part 'send_analytics_event_body.g.dart';

@freezed
abstract class SendAnalyticsEventBody implements _$SendAnalyticsEventBody {
  const SendAnalyticsEventBody._();

  const factory SendAnalyticsEventBody({
    required String event,
    required int accountId,
    required int? groupId,
    required String platform,
    required Map<String, String> metadata,
  }) = _SendAnalyticsEventBody;

  factory SendAnalyticsEventBody.fromJson(Map<String, dynamic> json) =>
      _$SendAnalyticsEventBodyFromJson(json);
}
