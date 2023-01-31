import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicalQuestionWrap extends StatelessWidget {
  final Widget child;
  final bool? isWithOnWillPop;
  final VoidCallback? onWillPop;

  const MedicalQuestionWrap({
    Key? key,
    required this.child,
    this.isWithOnWillPop,
    this.onWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepNavigationState(
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
    final bloc = context.read<MedicalFitnessBloc>();
    final nextRoute = bloc.state.currentQuestion.getNextQuestion().route;

    bloc.add(const MedicalFitnessEvent.nextQuestion());

    context.router.push(nextRoute);
  }

  Future<bool> _onPreviousPage(BuildContext context) {
    context.read<MedicalFitnessBloc>().add(
          const MedicalFitnessEvent.previousQuestion(),
        );

    onWillPop?.call();

    return Future.value(true);
  }
}
