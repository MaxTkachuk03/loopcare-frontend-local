import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_chat_report.freezed.dart';
part 'group_chat_report.g.dart';

@freezed
class GroupChatReport with _$GroupChatReport {
  const GroupChatReport._();

  const factory GroupChatReport({
    required int accountId,
    required int groupId,
    required int messageId,
    required String text,
  }) = _GroupChatReport;

  factory GroupChatReport.fromJson(Map<String, dynamic> json) => _$GroupChatReportFromJson(json);
}
