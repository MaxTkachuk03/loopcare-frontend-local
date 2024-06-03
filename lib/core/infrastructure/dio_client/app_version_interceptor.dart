import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bottom_sheet.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';

@injectable
class AppVersionInterceptor extends QueuedInterceptor {
  AppVersionInterceptor();

  SharedStorageService get _storage =>  getIt<SharedStorageService>();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
    _watchVersionHeader(response.headers);
  }

  void _watchVersionHeader(Headers headers) {
    final showPopup = _checkHeaderVersion(headers.map);

    if (showPopup) {
      AppUpdateBottomSheet.showAppUpdate();
    }
  }

  String get headerVersionProperty => Platform.isAndroid ? 'android-app-version' : 'ios-app-version';

  bool _checkHeaderVersion(Map<String, List<String>> headers) {
    if (headers.containsKey(headerVersionProperty) && _storage.localVersion > 1) {
      final version = int.tryParse(headers[headerVersionProperty]?.first ?? '') ?? 0;

      if (version > _storage.storeVersion) {
        _storage.storeVersion = version;
        return version > _storage.localVersion;
      }
    }

    return false;
  }
}

