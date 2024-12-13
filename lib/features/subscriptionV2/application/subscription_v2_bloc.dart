import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_services_v2.dart';

part 'subscription_v2_event.dart';
part 'subscription_v2_state.dart';
part 'subscription_v2_bloc.freezed.dart';

@singleton
class SubscriptionV2Bloc
    extends Bloc<SubscriptionV2Event, SubscriptionV2State> {
  final SubscriptionServicesV2 _subscriptionServicesV2;

  SubscriptionV2Bloc(this._subscriptionServicesV2)
      : super(SubscriptionV2State.initial(SubscriptionV2StateData())) {
    on<GetPlans>(_onGetPlans);
  }

  Future<void> _onGetPlans(
    GetPlans event,
    Emitter<SubscriptionV2State> emit,
  ) async {
    emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));

    final response = await _subscriptionServicesV2.getPlans();

    response.fold(
        (left) => emit(SubscriptionV2State.error(
            state.data.copyWith(error: left, isLoading: false))),
        (right) => emit(SubscriptionV2State.loaded(state.data.copyWith(
              id: right.id,
              type: right.type,
              title: right.title,
              label: right.label,
              subText: right.subText,
              plans: right.plans,
            ))));
  }
}
