import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/timer_state.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/widgets/progress_bar.dart';

class OnboardingQuestionsPage extends StatefulWidget {
  const OnboardingQuestionsPage({super.key});

  @override
  State<OnboardingQuestionsPage> createState() => _OnboardingQuestionsPageState();
}

class _OnboardingQuestionsPageState extends State<OnboardingQuestionsPage> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context
          .read<GeneralOnboardingBloc>()
          .add(const GeneralOnboardingEvent.resumeTimer());
    }
  }

  void _onPop(BuildContext context, isPhysicalIntro) {
    if (isPhysicalIntro) {
      context.router.pop();
    } else {
      context
          .read<GeneralOnboardingBloc>()
          .add(const GeneralOnboardingEvent.previousStep());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MedicalQuestionsBloc, MedicalQuestionsState>(
          listenWhen: (previous, current) => previous.sexType != current.sexType || previous.age != current.age,
          listener: _pregnancyListener,
        ),
        BlocListener<GeneralOnboardingBloc, GeneralOnboardingState>(
          listenWhen: (previous, current) => previous.mentalTimerState.isActive && current.mentalTimerState.isCompleted,
          listener: _mentalTimerComplete,
        ),
      ],
      child: BlocBuilder<GeneralOnboardingBloc, GeneralOnboardingState>(
        builder: (context, state) {
          Widget? backButton = const SizedBox.square();
          if (state.hasBackButton) {
            backButton = CustomFilledIconButton.fromColor(
              key: const ValueKey('onboarding_back_button'),
              color: state.generalStep.appBarComponentsColor,
              onPressed: () => _onPop(context, state.currentPhysicalStep.isIntro),
            );
          }

          String subtitle = '';
          if (state.hasSubtitle) {
            subtitle = LocalizedTexts.stepCounter.tr(
              args: [state.stepIndex.toString(), state.stepCount.toString()],
            );
          }

          final CustomAppBar appBar;
          if (state.hasAppBar) {
            appBar = CustomAppBar(
              title: state.generalStep.title.tr(),
              subtitle: subtitle,
              textTheme: state.generalStep == GeneralOnboardingStep.medical
                  ? CustomAppBarTextTheme.light
                  : CustomAppBarTextTheme.dark,
              backgroundColor: state.generalStep.primaryColor,
              leading: backButton,
              bottom: ProgressBar(
                backgroundColor: state.generalStep.primaryColor,
                progressFillColor: state.generalStep.secondaryColor,
                progressEmptyColor: state.generalStep.appBarComponentsColor,
                segments: GeneralOnboardingStep.values.length,
                value: state.generalStep.index,
                progress: state.progress,
              ),
            );
          } else {
            appBar = CustomAppBar(
              title: '',
              backgroundColor: state.generalStep.primaryColor,
              leading: backButton,
            );
          }

          return PopScope(
            canPop: state.currentPhysicalStep.isIntro,
            onPopInvoked: (_) => _onPop(context, state.currentPhysicalStep.isIntro),
            child: CustomScaffold(
              withBg: false,
              color: state.backgroundColor,
              appBar: appBar,
              body: SafeArea(
                bottom: false,
                child: ScrollableContainer(
                    physics: const ClampingScrollPhysics(),
                    child: state.currentStepContent
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pregnancyListener(BuildContext context, MedicalQuestionsState state) {
    final enablePregnancyQuestion = state.sexType == SexType.female && (state.age ?? 0) < 60;

    context.read<GeneralOnboardingBloc>().add(
      GeneralOnboardingEvent.updatePregnancyQuestion(enable: enablePregnancyQuestion),
    );
  }

  void _mentalTimerComplete(BuildContext context, GeneralOnboardingState state) {
    ModalBottomSheet.timeWasExceeded(
      context: context,
      onStartAgain: () {
        context.read<MentalQuestionsBloc>().add(const MentalQuestionsEvent.startTestFromBeginning());
        context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.startMentalTestFromBeginning());
        context.router.pop();
      },
    );
  }
}
