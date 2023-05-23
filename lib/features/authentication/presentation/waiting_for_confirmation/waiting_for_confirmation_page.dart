import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';

class WaitingForConfirmationPage extends StatefulWidget {
  const WaitingForConfirmationPage({Key? key}) : super(key: key);

  @override
  State<WaitingForConfirmationPage> createState() =>
      _WaitingForConfirmationPageState();
}

class _WaitingForConfirmationPageState extends State<WaitingForConfirmationPage>
    with WidgetsBindingObserver {
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
      listenWhen: (previous, current) =>
          previous is WaitedForConfirmation && current is Guest,
      listener: _authenticatedListener,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: SafeArea(
            child: ScrollableContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          LocalizedTexts.waitingForConfirmationTitle.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50.0,
                      horizontal: 45.0,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            LocalizedTexts.confirmYourAddress.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.blueDark,
                                  fontSize: 20.0,
                                ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            LocalizedTexts.checkSpam.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (BuildContext context, state) {
                            final email = state.mapOrNull(
                                    waitedForConfirmation: (state) =>
                                        state.email) ??
                                '';

                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                '${LocalizedTexts.address.tr()}: $email',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 50.0),
                        ElevatedButton(
                          onPressed: _onResendPressed,
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.bgGreen),
                                foregroundColor: MaterialStateProperty.all(
                                    AppColors.darkGreen),
                              ),
                          child: Text(
                            LocalizedTexts.resend.tr(),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: () => _onChangeAddressPressed(context),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.bgGreen),
                                foregroundColor: MaterialStateProperty.all(
                                    AppColors.darkGreen),
                              ),
                          child: Text(
                            LocalizedTexts.changeAddress.tr(),
                          ),
                        ),
                        const SizedBox(height: 80.0),
                      ],
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
    showAppSnackBar(
      context: context,
      background: AppColors.white,
      text: LocalizedTexts.resendConfirmationMessage.translation,
    );
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
          ..read<MedicalFitnessBloc>()
              .add(const MedicalFitnessEvent.resetData())
          ..read<PhysicalFitnessBloc>()
              .add(const PhysicalFitnessEvent.resetData())
          ..router.replaceAll([const LoginRoute()]);
      },
    );
  }
}
