import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class WaitingForConfirmationPage extends StatefulWidget {
  const WaitingForConfirmationPage({super.key});

  @override
  State<WaitingForConfirmationPage> createState() => _WaitingForConfirmationPageState();
}

class _WaitingForConfirmationPageState extends State<WaitingForConfirmationPage>
    with WidgetsBindingObserver {
  Timer? timer;
  bool waitingForResponse = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setTimer();
    }
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

  void _onContinue() {
    PageRouteInfo route;
    if (kIsProd || kIsStag) {
      route = const SubscriptionRouteV2();
    } else {
      route = const RiverOverviewRoute();
    }

    context
      ..read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.resetData())
      ..read<MedicalQuestionsBloc>().add(const MedicalQuestionsEvent.resetData())
      ..read<PhysicalQuestionsBloc>().add(const PhysicalQuestionsEvent.resetData())
      ..read<MentalQuestionsBloc>().add(const MentalQuestionsEvent.resetData())
      ..router.replaceAll([route]);
  }

  void _showEmailConfirmedBottomSheet() {
    timer?.cancel();

    ModalBottomSheet.emailConfirmed(
      context: context,
      onContinuePressed: _onContinue,
    );
  }

  void _onChangeAddress() {
    timer?.cancel();
    context.router.pushNamed(AppRoutes.changeEmail).whenComplete(setTimer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) => state.mapOrNull(
        gotEmailVerification: (_) => _showEmailConfirmedBottomSheet(),
      ),
      child: PopScope(
        canPop: false,
        child: CustomScaffold.blueLightest(
          key: const ValueKey('waiting_for_confirmation_page'),
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.createAccount.tr(),
            leading: const SizedBox.shrink(),
          ),
          body: CustomSafeArea(
            child: BottomPlacedButton.blueLightest(
              body: ListView(
                key: const ValueKey('waiting_for_confirmation_page_body'),
                physics: const ClampingScrollPhysics(),
                children: [
                  UnderAppbar.blue(
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
                              style:
                                  context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32.0),
                        CustomText.bitter600(
                          '${LocalizedTexts.waitingForConfirmationSubtitle.tr()}!',
                          style: context.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          '${LocalizedTexts.waitingForConfirmationBody.tr()}.',
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          key: const ValueKey('waiting_for_confirmation_email_line'),
                          builder: (context, state) {
                            return OccludeWrapper(
                              child: CustomText.w600(
                                state.data.email,
                                style: context.textTheme.bodyMedium,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              button: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton.blueFullWidth(
                    key: const ValueKey('waiting_for_confirmation_button'),
                    label: LocalizedTexts.continueBtn.tr(),
                    onPressed: _onContinue,
                  ),
                  const SizedBox(height: 21.0),
                  RichText(
                    key: const ValueKey('waiting_for_confirmation_rich_text'),
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(text: '${LocalizedTexts.incorrectEmail.tr()} '),
                        TextSpan(
                          text: LocalizedTexts.changeAddress.tr(),
                          style:
                              context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()..onTap = _onChangeAddress,
                        ),
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
}
