import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/app_update/app_version_service.dart';
import 'package:loopcare_frontend/core/application/app_update/dto/get_versions_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'app_update_event.dart';
part 'app_update_state.dart';
part 'app_update_bloc.freezed.dart';

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

    response.fold(
      (l) => emit(AppUpdateState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(AppUpdateState.loaded(state.data.copyWith(versions: r, isLoading: false, error: null))),
    );
  }
}
