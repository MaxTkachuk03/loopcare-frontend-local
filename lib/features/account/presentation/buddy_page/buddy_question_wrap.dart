import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_questions.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/step_navigation_state.dart';

class BuddyQuestionWrap extends StatelessWidget {
  final Widget child;

  const BuddyQuestionWrap({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StepNavigationState(
      onNextPage: () => _onNextPage(context),
      onPreviousPage: () => _onPreviousPage(context),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          _onPreviousPage(context);
          context.router.popForced();
        },
        child: child,
      ),
    );
  }

  void _onNextPage(BuildContext context) {
    final bloc = context.read<BuddyBloc>();
    final nextRoute = bloc.state.data.currentQuestion.getNextQuestion().route;
    bloc.add(const BuddyEvent.nextQuestion());
    context.router.push(nextRoute);
  }

  Future<bool> _onPreviousPage(BuildContext context) {
    context.read<BuddyBloc>().add(const BuddyEvent.previousQuestion());
    return Future.value(true);
  }
}
