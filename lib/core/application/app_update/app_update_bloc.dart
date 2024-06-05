import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/app_update/app_version_service.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_update_bloc.freezed.dart';
part 'app_update_event.dart';
part 'app_update_state.dart';

@singleton
class AppUpdateBloc extends Bloc<AppUpdateEvent, AppUpdateState> {
  final AppVersionService _appVersionService;

  AppUpdateBloc(this._appVersionService) : super(const AppUpdateState.initial(AppUpdateData())) {
    on<GetVersion>(_onGetVersion);
  }

  FutureOr<void> _onGetVersion(
    GetVersion event,
    Emitter<AppUpdateState> emit,
  ) async {
    emit(AppUpdateState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _appVersionService.getVersions();

    final info = await PackageInfo.fromPlatform();

    response.fold(
      (l) => emit(AppUpdateState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        final storage = getIt<SharedStorageService>();

        final platformMinVersion = Platform.isIOS ? r.iosMinVersion : r.androidMinVersion;

        final localVersion = int.parse(info.buildNumber);

        storage.localVersion = localVersion;
        storage.storeVersion = platformMinVersion;

        storage.privacyPolicyVersion = r.privacyPolicyVersion;
        storage.termsAndConditionsVersion = r.termsAndConditionsVersion;

        final needToUpdate = localVersion < platformMinVersion;

        emit(
          AppUpdateState.loaded(
            state.data.copyWith(
              needToUpdate: needToUpdate,
              privacyPolicyVersion: r.privacyPolicyVersion,
              termsAndConditionsVersion: r.termsAndConditionsVersion,
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }
}
