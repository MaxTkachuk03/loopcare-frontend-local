import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';

class QuestionWrap extends StatelessWidget {
  final Widget child;
  final bool? isWithOnWillPop;
  final Future<bool> Function() onPreviousPage;

  const QuestionWrap({
    Key? key,
    required this.child,
    required this.onPreviousPage,
    this.isWithOnWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWithOnWillPop = this.isWithOnWillPop;

    return WillPopScope(
      onWillPop:
          isWithOnWillPop != null && !isWithOnWillPop ? null : onPreviousPage,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizedTexts.bodyAndMind.tr()),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProgressBar(),
                  BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                    builder: (_, state) {
                      // print('PhysicalFitnessBloc ${state.currentQuestion} ${state.isCompleted}');

                      return Text('123');
                    },
                  ),
                  child,
                  // child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
