import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_chat_report.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';

part 'report_abuse_data.g.dart';

@immutable
@JsonSerializable()
class ReportAbuseData {
  final String subject;
  final String message;
  final String appVersion;
  final GroupSessionReport? groupSession;
  final GroupChatReport? groupChat;

  const ReportAbuseData({
    required this.subject,
    required this.message,
    required this.appVersion,
    this.groupSession,
    this.groupChat,
  });

  factory ReportAbuseData.fromJson(Map<String, dynamic> json) => _$ReportAbuseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportAbuseDataToJson(this);
}
