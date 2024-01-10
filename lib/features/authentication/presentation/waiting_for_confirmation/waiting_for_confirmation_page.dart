import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';

class WaitingForConfirmationPage extends StatefulWidget {
  const WaitingForConfirmationPage({super.key});

  @override
  State<WaitingForConfirmationPage> createState() => _WaitingForConfirmationPageState();
}

class _WaitingForConfirmationPageState extends State<WaitingForConfirmationPage> with WidgetsBindingObserver {
  Timer? timer;
  bool waitingForResponse = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void setTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!waitingForResponse) {
        waitingForResponse = true;
        await context.read<AuthenticationCubit>().authenticatedCheck();
        waitingForResponse = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listenWhen: (previous, current) => previous is WaitedForConfirmation && current is Guest,
      listener: _authenticatedListener,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: CustomScaffold.green(
          appBar: CustomAppBar.green(
            title: LocalizedTexts.createAccount.tr(),
            leading: CustomFilledIconButton.leadingGreenLighter(),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: Column(
                children: [
                  UnderAppbar.green(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mail, size: 44, color: AppColors.white),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              '${LocalizedTexts.waitingForConfirmationTitle.tr()}!',
                              style: context.textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  MainContainer(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText.w400(
                            '${LocalizedTexts.waitingForConfirmationBody1.tr()}:',
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20.0),
                          BlocBuilder<AuthenticationCubit, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              final email =
                                  state.mapOrNull(waitedForConfirmation: (state) => state.email) ?? '';

                              return CustomText.w600(email, style: context.textTheme.bodyMedium);
                            },
                          ),
                          const SizedBox(height: 20.0),
                          CustomText.w400(
                            '${LocalizedTexts.waitingForConfirmationBody2.tr()}.',
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20.0),
                          CustomText.w400(
                            '${LocalizedTexts.waitingForConfirmationBody3.tr()}.',
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20.0),
                          CustomText.w400(
                            '${LocalizedTexts.waitingForConfirmationBody4.tr()}.',
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 50.0),
                          CustomOutlinedButton.blueFullWidth(
                            onPressed: _onResendPressed,
                            label: LocalizedTexts.resend,
                          ),
                          const SizedBox(height: 12.0),
                          CustomOutlinedButton.blueFullWidth(
                            onPressed: () => _onChangeAddressPressed(context),
                            label: LocalizedTexts.changeAddress,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    context.read<AuthenticationCubit>().previousStep();

    return Future.value(true);
  }

  void _onResendPressed() {
    context.read<AuthenticationCubit>().resendEmail();
    context.showSuccessBar(content: CustomText.w400(LocalizedTexts.resendConfirmationMessage.tr()));
  }

  void _onChangeAddressPressed(BuildContext context) {
    context.router.pop();
  }

  void _authenticatedListener(BuildContext context, state) {
    timer?.cancel();
    ModalBottomSheet.emailConfirmed(
      context: context,
      onContinuePressed: () {
        context
          ..read<OnboardingBloc>().add(const OnboardingEvent.resetData())
          ..read<MedicalFitnessBloc>().add(const MedicalFitnessEvent.resetData())
          ..read<PhysicalFitnessBloc>().add(const PhysicalFitnessEvent.resetData())
          ..read<MentalHealthBloc>().add(const MentalHealthEvent.resetData())
          ..router.replaceAll([const LoginRoute()]);
      },
    );
  }
}
