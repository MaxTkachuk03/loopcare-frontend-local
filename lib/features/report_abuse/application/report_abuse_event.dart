part of 'report_abuse_bloc.dart';

@freezed
class ReportAbuseEvent with _$ReportAbuseEvent {
  const factory ReportAbuseEvent.sendReport(String subject, String message, {GroupSessionReport? groupSession}) =
      SendReportIssue;

  const factory ReportAbuseEvent.init() = SendReportInit;
}
