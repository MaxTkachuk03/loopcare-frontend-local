import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/error_invoker.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/timer_state.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/widgets/progress_bar.dart';

@RoutePage()
class OnboardingQuestionsPage extends StatefulWidget {
  const OnboardingQuestionsPage({super.key});

  @override
  State<OnboardingQuestionsPage> createState() => _OnboardingQuestionsPageState();
}

class _OnboardingQuestionsPageState extends State<OnboardingQuestionsPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.resumeTimer());
    }
  }

  void _onPop(BuildContext context, isPhysicalIntro) {
    if (isPhysicalIntro) {
      context.router.maybePop();
    } else {
      context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.previousStep());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MedicalQuestionsBloc, MedicalQuestionsState>(
          listenWhen: (previous, current) =>
              previous.sexType != current.sexType || previous.age != current.age,
          listener: _pregnancyListener,
        ),
        BlocListener<GeneralOnboardingBloc, GeneralOnboardingState>(
          listenWhen: (previous, current) =>
              previous.mentalTimerState.isActive && current.mentalTimerState.isCompleted,
          listener: _mentalTimerComplete,
        ),
      ],
      child: BlocBuilder<GeneralOnboardingBloc, GeneralOnboardingState>(
        builder: (context, state) {
          Widget backButton = CustomFilledIconButton.fromColor(
            key: const ValueKey('onboarding_back_button'),
            color: state.generalStep.appBarComponentsColor,
            onPressed: () => _onPop(context, state.currentPhysicalStep.isIntro),
          );

          String subtitle = '';
          if (state.hasSubtitle) {
            subtitle = LocalizedTexts.stepCounter.tr(
              {'currentStep': state.stepIndex, 'totalSteps': state.stepCount},
            );
          }

          final CustomAppBar appBar;
          if (state.hasAppBar) {
            appBar = CustomAppBar(
              title: state.generalStep.title.tr(),
              subtitle: subtitle,
              textTheme: state.generalStep == GeneralOnboardingStep.mental
                  ? CustomAppBarTextTheme.light
                  : CustomAppBarTextTheme.dark,
              backgroundColor: state.generalStep.primaryColor,
              leading: CustomFilledIconButton.fromColor(
                key: const ValueKey('onboarding_back_button'),
                color: state.generalStep.appBarComponentsColor,
                onPressed: () => _onPop(context, state.currentPhysicalStep.isIntro),
              ),
              actions: const [
                ErrorInvokeButton(),
              ],
              bottom: state.showProgressBar
                  ? ProgressBar(
                      backgroundColor: state.generalStep.primaryColor,
                      progressFillColor: state.generalStep.secondaryColor,
                      progressEmptyColor: state.generalStep.appBarComponentsColor,
                      segments: GeneralOnboardingStep.values.length,
                      value: state.generalStep.index,
                      progress: state.progress,
                    )
                  : null,
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
              body: ErrorInvoker(
                child: CustomSafeArea(
                  bottom: false,
                  child: state.currentStepContent,
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
        context
            .read<MentalQuestionsBloc>()
            .add(const MentalQuestionsEvent.startTestFromBeginning());
        context
            .read<GeneralOnboardingBloc>()
            .add(const GeneralOnboardingEvent.startMentalTestFromBeginning());
        context.router.maybePop();
      },
    );
  }
}
