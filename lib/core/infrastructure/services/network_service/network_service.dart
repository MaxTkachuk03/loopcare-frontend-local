// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkStatusService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<NetworkStatus> networkStatusController = StreamController<NetworkStatus>();

  NetworkStatusService() {
    _connectivity.onConnectivityChanged.listen((statuses) {
      if (!networkStatusController.isClosed) {
        networkStatusController.add(_getNetworkStatus(statuses));
      }
    });
  }

  NetworkStatus _getNetworkStatus(List<ConnectivityResult> statuses) {
    return statuses.contains(ConnectivityResult.mobile) || statuses.contains(ConnectivityResult.wifi)
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void dispose() => networkStatusController.close();
}
