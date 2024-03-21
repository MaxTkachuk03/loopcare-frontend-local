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
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';

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
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setTimer();
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
        context.read<AuthenticationBloc>().add(const AuthenticationEvent.authenticatedCheck());
        waitingForResponse = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous is WaitedConfirmationState && current is GuestAuthenticationState,
      listener: _authenticatedListener,
      child: PopScope(
        canPop: false,
        child: CustomScaffold.green(
          key: const ValueKey('waiting_for_confirmation_page'),
          appBar: CustomAppBar.green(
            title: LocalizedTexts.createAccount.tr(),
            leading: const SizedBox.shrink(),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: Column(
                key: const ValueKey('waiting_for_confirmation_page_body'),
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
                      padding: const EdgeInsets.all(32),
                      decoration: const BoxDecoration(
                        color: AppColors.greenLightest,
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
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            key: const ValueKey('waiting_for_confirmation_email_line'),
                            builder: (context, state) {
                              final email =
                                  state.mapOrNull(waitedForConfirmation: (state) => state.data.email) ?? '';

                              return CustomText.w600(
                                email,
                                style: context.textTheme.bodyMedium,
                              );
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
                          CustomOutlinedButton.petrolFullWidth(
                            key: const ValueKey('resend_email_button'),
                            onPressed: _onResendPressed,
                            label: LocalizedTexts.resend,
                          ),
                          // todo: discuss with Diana
                          // const SizedBox(height: 12.0),
                          // CustomOutlinedButton.petrolFullWidth(
                          //   key: const ValueKey('change_email_button'),
                          //   onPressed: () => _onChangeAddressPressed(context),
                          //   label: LocalizedTexts.changeAddress,
                          // ),
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

  void _onResendPressed() {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.resendEmail());
    context.showSuccessBar(content: CustomText.w400(LocalizedTexts.resendConfirmationMessage.tr()));
  }

  void _onChangeAddressPressed(BuildContext context) => context.router.pop();

  void _authenticatedListener(BuildContext context, state) {
    timer?.cancel();

    ModalBottomSheet.emailConfirmed(
      context: context,
      onContinuePressed: () {
        context
          ..read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.resetData())
          ..read<MedicalQuestionsBloc>().add(const MedicalQuestionsEvent.resetData())
          ..read<PhysicalQuestionsBloc>().add(const PhysicalQuestionsEvent.resetData())
          ..read<MentalQuestionsBloc>().add(const MentalQuestionsEvent.resetData())
          ..router.replaceAll([const LoginRoute()]);
      },
    );
  }
}
