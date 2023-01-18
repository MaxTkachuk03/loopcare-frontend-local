import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_fitness_navigation_state.dart';

class PhysicalQuestionWrap extends StatelessWidget {
  final Widget child;
  final bool? isWithOnWillPop;

  const PhysicalQuestionWrap({
    Key? key,
    required this.child,
    this.isWithOnWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalFitnessNavigationState(
      onNextPage: () => _onNextPage(context),
      onPreviousPage: () => _onPreviousPage(context),
      child: QuestionWrap(
        isWithOnWillPop: isWithOnWillPop,
        onPreviousPage: () => _onPreviousPage(context),
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
    context.read<PhysicalFitnessBloc>().add(
          const PhysicalFitnessEvent.previousQuestion(),
        );

    return Future.value(true);
  }
}
