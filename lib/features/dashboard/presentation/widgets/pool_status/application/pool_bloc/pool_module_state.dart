part of 'pool_module_bloc.dart';

@freezed
class PoolModuleState with _$PoolModuleState {
  const factory PoolModuleState.initial() = PoolInitial;
  const factory PoolModuleState.loading() = PoolLoading;
  const factory PoolModuleState.loaded(PoolResponse data) = PoolLoaded;
  const factory PoolModuleState.error(String error) = PoolError;
}
