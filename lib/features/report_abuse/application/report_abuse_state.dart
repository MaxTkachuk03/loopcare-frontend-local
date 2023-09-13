part of 'report_abuse_bloc.dart';

@freezed
class ReportAbuseState with _$ReportAbuseState {
  const factory ReportAbuseState.initial(ReportAbuseStateData data) = _Initial;

  const factory ReportAbuseState.sentSuccess(ReportAbuseStateData data) = _Updated;

  const factory ReportAbuseState.loading(ReportAbuseStateData data) = _Loading;

  const factory ReportAbuseState.error(ReportAbuseStateData data) = _Error;
}

@freezed
class ReportAbuseStateData with _$ReportAbuseStateData {
  const ReportAbuseStateData._();

  const factory ReportAbuseStateData({
    RequestError? error,
    @Default(false) bool isLoading,
  }) = _ReportAbuseStateData;
}