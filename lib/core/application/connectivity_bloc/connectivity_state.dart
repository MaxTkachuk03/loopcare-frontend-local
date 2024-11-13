part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial(
    ConnectivityStatus status,
  ) = ConnectivityInitial;

  const factory ConnectivityState.statusChanged(
    ConnectivityStatus status,
  ) = ConnectivityStateUpdate;
}

enum ConnectivityStatus {
  online,
  offline;

  bool get isOffline => this == offline;
}
