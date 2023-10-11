import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'manage_subscription_event.dart';

part 'manage_subscription_state.dart';

part 'manage_subscription_bloc.freezed.dart';

@singleton
class ManageSubscriptionBloc extends Bloc<ManageSubscriptionEvent, ManageSubscriptionState> {
  ManageSubscriptionBloc() : super(const ManageSubscriptionState.initial(ManageSubscriptionData())) {
    on<ManageSubscriptionInit>(_onInitSubscription);
    on<CancelActiveSubscription>(_onCancelActiveSubscription);
    on<GetActiveSubscriptionPlan>(_onGetActiveSubscriptionPlans);
  }

  FutureOr<void> _onInitSubscription(
    ManageSubscriptionInit event,
    Emitter<ManageSubscriptionState> emit,
  ) async {
    emit(const ManageSubscriptionState.initial(ManageSubscriptionData()));
  }

  FutureOr<void> _onCancelActiveSubscription(
    CancelActiveSubscription event,
    Emitter<ManageSubscriptionState> emit,
  ) async {
    emit(const ManageSubscriptionState.subscriptionCancelled(ManageSubscriptionData()));
  }

  FutureOr<void> _onGetActiveSubscriptionPlans(
    GetActiveSubscriptionPlan event,
    Emitter<ManageSubscriptionState> emit,
  ) async {
    emit(const ManageSubscriptionState.success(ManageSubscriptionData()));
  }
}
