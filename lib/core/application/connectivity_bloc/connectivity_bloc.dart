import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

@singleton
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> listener;

  ConnectivityBloc() : super(const ConnectivityState.initial(ConnectivityStatus.online)) {
    on<UpdateConnectivityStatus>(_onUpdateConnectivity);
    on<InitConnectivity>(_onInitConnectivity);

    listener = _connectivity.onConnectivityChanged.listen((statuses) {
        add(ConnectivityEvent.updateStatus(statuses));
    });
  }


  @override
  Future<void> close() {
    listener.cancel();
    return super.close();
  }

  FutureOr<void> _onInitConnectivity(
    InitConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    final statuses = await _connectivity.checkConnectivity();

    emit(ConnectivityState.statusChanged(_getConnectivityStatus(statuses)));
  }

  FutureOr<void> _onUpdateConnectivity(
    UpdateConnectivityStatus event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(ConnectivityState.statusChanged(_getConnectivityStatus(event.statuses)));
  }

  ConnectivityStatus _getConnectivityStatus(List<ConnectivityResult> statuses) {
    return statuses.contains(ConnectivityResult.mobile) ||
        statuses.contains(ConnectivityResult.wifi)
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;
  }
}
