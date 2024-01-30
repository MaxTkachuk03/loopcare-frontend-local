part of 'app_update_bloc.dart';

@freezed
class AppUpdateState with _$AppUpdateState {
  const factory AppUpdateState.initial(AppUpdateData data) = AppUpdateStateInitial;

  const factory AppUpdateState.loading(AppUpdateData data) = AppUpdateStateLoading;

  const factory AppUpdateState.loaded(AppUpdateData data) = AppUpdateStateLoaded;

  const factory AppUpdateState.error(AppUpdateData data) = AppUpdateStateError;
}

@freezed
class AppUpdateData with _$AppUpdateData {
  const AppUpdateData._();

  const factory AppUpdateData({
    @Default(GetVersionsResponse(isEnabled: true, androidMinVersion: 1, iosMinVersion: 1))
    GetVersionsResponse versions,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _AppUpdateData;

  get iosMinVersion => versions.iosMinVersion;

  get androidMinVersion => versions.androidMinVersion;
}
