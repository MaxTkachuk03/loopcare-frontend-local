import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_chat_report.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/report_abuse_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'report_abuse_bloc.freezed.dart';
part 'report_abuse_event.dart';
part 'report_abuse_state.dart';

@singleton
class ReportAbuseBloc extends Bloc<ReportAbuseEvent, ReportAbuseState> {
  final AuthenticationService _authenticationService;

  ReportAbuseBloc(this._authenticationService)
      : super(const ReportAbuseState.initial(ReportAbuseStateData())) {
    on<SendReportInit>(_onInitReportAbuse);
    on<SendReportIssue>(_onSendReportAbuse);
  }

  FutureOr<void> _onInitReportAbuse(
    SendReportInit event,
    Emitter<ReportAbuseState> emit,
  ) async =>
      emit(const ReportAbuseState.initial(ReportAbuseStateData()));

  FutureOr<void> _onSendReportAbuse(
    SendReportIssue event,
    Emitter<ReportAbuseState> emit,
  ) async {
    emit(ReportAbuseState.loading(state.data.copyWith(isLoading: true)));

    final packageInfo = await PackageInfo.fromPlatform();

    final report = ReportAbuseData(
      subject: event.subject,
      message: event.message,
      appVersion: packageInfo.version,
      groupSession: event.groupSession,
      groupChat: event.chatReport,
    );
    final response = await _authenticationService.reportAbuse(report);

    response.fold(
      (l) => emit(ReportAbuseState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        ReportAbuseState.sentSuccess(
          state.data.copyWith(
            isLoading: false,
            error: null,
          ),
        ),
      ),
    );
  }
}
