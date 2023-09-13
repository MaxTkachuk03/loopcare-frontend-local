import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_session_report.freezed.dart';

part 'group_session_report.g.dart';

@freezed
class GroupSessionReport with _$GroupSessionReport {
  const GroupSessionReport._();

  const factory GroupSessionReport({
    required int id,
    required String time,
  }) = _GroupSessionReport;

  factory GroupSessionReport.fromJson(Map<String, dynamic> json) => _$GroupSessionReportFromJson(json);
}
