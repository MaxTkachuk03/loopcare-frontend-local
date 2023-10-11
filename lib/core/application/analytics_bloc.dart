import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/analytics_service.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_body.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';
part 'analytics_bloc.freezed.dart';

@singleton
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsService _analyticsService;
  final AuthenticationCubit _authenticationCubit;

  AnalyticsBloc(this._analyticsService, this._authenticationCubit)
      : super(const AnalyticsState.initial(AnalyticsData())) {
    on<SendAnalytics>(_onSendAnalytics);
  }

  FutureOr<void> _onSendAnalytics(
    SendAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(AnalyticsState.loading(state.data.copyWith(error: null, isLoading: true)));

    final packageInfo = await PackageInfo.fromPlatform();

    final platform =
        'Platform - ${Platform.operatingSystem}(${Platform.operatingSystemVersion}) app version - ${packageInfo.version} ( ${packageInfo.buildNumber} )';

    final userId = _authenticationCubit.state.id;
    final userGroupId = _authenticationCubit.state.groupId;

    final data = SendAnalyticsEventBody(
      event: event.name,
      accountId: userId,
      groupId: userGroupId,
      platform: platform,
      metadata: event.data,
    );

    final response = await _analyticsService.sendEvent(data);

    response.fold(
      (l) => emit(AnalyticsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(AnalyticsState.success(state.data.copyWith(
        lastEvent: r,
        isLoading: false,
        error: null,
      ))),
    );
  }
}
