import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class PhysicalQuestionWrap extends StatelessWidget {
  final Widget child;
  final bool? isWithOnWillPop;

  const PhysicalQuestionWrap({
    super.key,
    required this.child,
    this.isWithOnWillPop,
  });

  @override
  Widget build(BuildContext context) {
    return StepNavigationState(
      onNextPage: () => _onNextPage(context),
      onPreviousPage: () => _onPreviousPage(context),
      child: WillPopScope(
        onWillPop: () => _onPreviousPage(context),
        child: child,
      ),
    );
  }

  void _onNextPage(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();
    final nextRoute = bloc.state.currentQuestion.getNextQuestion().route;

    bloc.add(const PhysicalFitnessEvent.nextQuestion());

    context.router.push(nextRoute);
  }

  Future<bool> _onPreviousPage(BuildContext context) {
    final isWithOnWillPop = this.isWithOnWillPop;
    if (isWithOnWillPop != null && !isWithOnWillPop) {
    } else {
      context.read<PhysicalFitnessBloc>().add(const PhysicalFitnessEvent.previousQuestion());
    }

    return Future.value(true);
  }
}
