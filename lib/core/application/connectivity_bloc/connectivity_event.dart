part of 'connectivity_bloc.dart';

@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.init() = InitConnectivity;

  const factory ConnectivityEvent.updateStatus(List<ConnectivityResult> statuses) =
      UpdateConnectivityStatus;
}
