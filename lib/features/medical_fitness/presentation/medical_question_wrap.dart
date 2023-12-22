import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicalQuestionWrap extends StatelessWidget {
  final Widget child;
  final bool? isWithOnWillPop;
  final VoidCallback? onWillPop;

  const MedicalQuestionWrap({
    super.key,
    required this.child,
    this.isWithOnWillPop,
    this.onWillPop,
  });

  _onWillPopHandler(BuildContext context) {
    final isWithOnWillPop = this.isWithOnWillPop;

    return isWithOnWillPop != null && !isWithOnWillPop ? null : _onPreviousPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return StepNavigationState(
      onNextPage: () => _onNextPage(context),
      onPreviousPage: () => _onPreviousPage(context),
      child: WillPopScope(
        onWillPop: () => _onWillPopHandler(context),
        child: CustomScaffold(
          appBar: CustomAppBar.yellow(
            title: LocalizedTexts.physicalIntroTitle.tr(),
            leading: CustomFilledIconButton.leadingYellowLighter(),
          ),
          body: SafeArea(
            bottom: false,
            child: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPage(BuildContext context) {
    final bloc = context.read<MedicalFitnessBloc>();
    final nextRoute = getQuestionRoute(
      getNextQuestion(bloc.state.currentQuestion),
    );

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
