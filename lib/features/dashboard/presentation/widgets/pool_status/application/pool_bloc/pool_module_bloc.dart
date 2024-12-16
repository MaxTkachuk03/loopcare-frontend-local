import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/domain/pool_module_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/pool_response.dart';

part 'pool_module_bloc.freezed.dart';
part 'pool_module_event.dart';
part 'pool_module_state.dart';

@singleton
class PoolModuleBloc extends Bloc<PoolModuleEvent, PoolModuleState> {
  final PoolModuleService _poolModuleService;

  PoolModuleBloc(this._poolModuleService) : super(const PoolModuleState.initial()) {
    on<_GetPoolData>(_getPoolData);
  }

  // Inside PoolModuleBloc

  FutureOr<void> _getPoolData(
    _GetPoolData event,
    Emitter<PoolModuleState> emit,
  ) async {
    emit(const PoolModuleState.loading());

    final response = await _poolModuleService.fetchPoolData();

    response.fold(
      (l) => emit(PoolModuleState.error(l.toString())),
      (r) => emit(
        PoolModuleState.loaded(r),
      ),
    );
  }
}
