import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class MentalHealthIntroPage extends StatefulWidget {
  const MentalHealthIntroPage({super.key});

  @override
  State<MentalHealthIntroPage> createState() => _MentalHealthIntroPageState();
}

class _MentalHealthIntroPageState extends State<MentalHealthIntroPage> {
  Timer? _timer;

  @override
  void initState() {
    _onLoadTests();

    if (context.read<MentalHealthBloc>().state.data.startTestTime != null) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MentalHealthWrap(
      child: CustomScaffold.orangeLightest(
        appBar: CustomAppBar.orange(
          title: LocalizedTexts.mentalHealth.tr(),
          leading: CustomFilledIconButton.leadingOrangeLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: BlocBuilder<MentalHealthBloc, MentalHealthState>(builder: (context, state) {
              if (state.data.isLoading) return const Loader();

              final error = state.data.error;

              if (error != null) {
                return ErrorScreen(
                  error: error,
                  onButtonPressed: _onLoadTests,
                );
              }

              return MultiBlocListener(
                listeners: [
                  BlocListener<MentalHealthBloc, MentalHealthState>(
                    listenWhen: (prev, cur) =>
                        prev.data.startTestTime == null && cur.data.startTestTime != null,
                    listener: _listenerTestWasStarted,
                  ),
                  BlocListener<MentalHealthBloc, MentalHealthState>(
                    listenWhen: (prev, cur) => !prev.data.isCompleted && cur.data.isCompleted,
                    listener: _listenerTestWasCompleted,
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProgressBar.blue(backgroundColor: AppColors.orangeRegular),
                        MainContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24.0),
                              CustomText.w600(
                                LocalizedTexts.yourMentalHealth,
                                style: context.textTheme.displayMedium,
                              ),
                              const SizedBox(height: 28.0),
                              CustomText.w600(
                                '${LocalizedTexts.mentalHealthIntroTextOne.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                '${LocalizedTexts.mentalHealthIntroTextTwo.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                '${LocalizedTexts.mentalHealthIntroTextThree.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                '${LocalizedTexts.mentalHealthIntroTextFour.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                '${LocalizedTexts.mentalHealthIntroTextFive.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                '${LocalizedTexts.mentalHealthIntroTextSix.tr()}.',
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    MainContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomOutlinedButton.orangeSmall(
                            label: LocalizedTexts.moreInfo.tr(),
                            onPressed: () => _onMoreInfoPressed(context),
                          ),
                          const SizedBox(height: 26.0),
                          CustomElevatedButton.blueFullWidth(
                            onPressed: () => _onNextPressed(context),
                            label: LocalizedTexts.next.tr(),
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _onLoadTests() {
    context.read<MentalHealthBloc>().add(const MentalHealthEvent.getMentalHealthTests());
  }

  void _startTimer() {
    final bloc = context.read<MentalHealthBloc>();
    final startTestTime = bloc.state.data.startTestTime;

    if (startTestTime == null) return;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final mentalHealthTime = int.parse(dotenv.env['MENTAL_HEALTH_TEST_TIME_IN_MINUTES']!);
        final timeWasExceededCheck =
            DateTime.now().isAfter(startTestTime.add(Duration(minutes: mentalHealthTime)));

        if (timeWasExceededCheck) {
          timer.cancel();

          ModalBottomSheet.timeWasExceeded(
            context: context,
            onStartAgain: () {
              bloc.add(const MentalHealthEvent.startTestFromBeginning());
              context.router.popUntilRouteWithName(MentalHealthIntroRoute.name);
            },
          );
        }
      },
    );
  }

  _onNextPressed(BuildContext context) {
    final bloc = context.read<MentalHealthBloc>();

    if (bloc.state.data.startTestTime == null) {
      bloc.add(MentalHealthEvent.setStartTime(DateTime.now()));
    }

    bloc.add(const MentalHealthEvent.nextPage());
    context.router.pushNamed(AppRoutes.mentalHealthQuestion);
  }

  void _listenerTestWasStarted(BuildContext context, MentalHealthState state) {
    _startTimer();
  }

  void _listenerTestWasCompleted(BuildContext context, MentalHealthState state) {
    _timer?.cancel();
  }

  _onMoreInfoPressed(BuildContext context) {
    ModalBottomSheet.mentalHealthMoreInfo(context: context);
  }
}
