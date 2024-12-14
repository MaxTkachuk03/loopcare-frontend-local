import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/analytics_service.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_body.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'analytics_bloc.freezed.dart';
part 'analytics_event.dart';
part 'analytics_state.dart';

@singleton
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsService _analyticsService;
  final SharedStorageService _storage;

  AnalyticsBloc(this._analyticsService, this._storage)
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

    final userId = _storage.account?.id ?? -1;
    final userGroupId = _storage.account?.groupId;

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
