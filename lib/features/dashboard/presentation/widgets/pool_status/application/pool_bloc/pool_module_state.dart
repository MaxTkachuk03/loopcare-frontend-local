part of 'pool_module_bloc.dart';

@freezed
class PoolModuleState with _$PoolModuleState {
  const factory PoolModuleState.initial() = _Initial;
  const factory PoolModuleState.loading() = _Loading;
  const factory PoolModuleState.loaded(PoolResponse data) = _Loaded;
  const factory PoolModuleState.error(String error) = _Error;
}
