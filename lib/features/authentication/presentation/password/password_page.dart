import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_with_indicator.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _formValidationNotifier = ValueNotifier<bool>(false);

  bool _termsAndConditionsAreChecked = false;
  bool _privatePolicyAccepted = false;
  bool _passwordValidationPassed = false;

  @override
  void initState() {
    super.initState();
    final email = context.read<AuthenticationBloc>().state.data.email;
    _emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formValidationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => (ModalRoute.of(context)?.isCurrent ?? false),
          listener: (_, state) => state.mapOrNull(
            error: _errorListener,
            // waitedForConfirmation: _navigationListener,
            gotAccount: _onGotAccount,
          ),
        ),
        BlocListener<RiverBloc, RiverState>(
          listener: (context, state) {
            state.mapOrNull(
              moduleLoaded: _onRiverModulesLoaded,
            );
          },
        )
      ],
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: CustomScaffold.blueLightest(
          key: const ValueKey('password_page'),
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.createAccount.tr(),
            leading: CustomFilledIconButton.leadingBlueLighter(),
          ),
          body: CustomSafeArea(
            child: BottomPlacedButton.blueLightest(
              body: MainContainer(
                child: AutofillGroup(
                  child: ListView(
                    key: const ValueKey('password_page_body'),
                    physics: const ClampingScrollPhysics(),
                    children: [
                      const SizedBox(height: 35.0),
                      CustomText.bitter600(
                        '${LocalizedTexts.enterPasswordSubTitle.tr()}?',
                        style: context.textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: 30.0,
                        child: Opacity(
                          opacity: 0.0,
                          child: CustomTextField.hiddenEmail(
                            key: const ValueKey('password_page_hidden_email'),
                            controller: _emailController,
                          ),
                        ),
                      ),
                      OccludeWrapper(
                        child: PasswordWithIndicator(
                          key: const ValueKey('password_page_with_indicator'),
                          controller: _passwordController,
                          onChange: _onPasswordChanged,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CheckboxFormField(
                        key: const ValueKey('registration_terms_conditions_checkbox'),
                        errorText: '${LocalizedTexts.pleaseAcceptTOC.tr()}.',
                        text: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            text: '${LocalizedTexts.iAcceptThe.tr()} ',
                            style: context.textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTermsAndConditionsTap,
                                text: LocalizedTexts.termsAndConditions.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onChanged: _onTermsAndConditionsChanged,
                      ),
                      const SizedBox(height: 10),
                      CheckboxFormField(
                        key: const ValueKey('registration_privacy_policy_checkbox'),
                        errorText: '${LocalizedTexts.pleaseAcceptPrivacyPolicy.tr()}.',
                        text: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            text: '${LocalizedTexts.iAcceptThe.tr()} ',
                            style: context.textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = _onPrivacyPolicyTap,
                                text: LocalizedTexts.privacyPolicy.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onChanged: _onPrivacyPolicyChanged,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
              button: ValueListenableBuilder<bool>(
                valueListenable: _formValidationNotifier,
                builder: (context, isValid, _) {
                  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      final isLoading = state is AuthenticationStateIsLoading;

                      return CustomElevatedButton.blueFullWidth(
                        key: const ValueKey('password_page_next_button'),
                        onPressed: isValid ? _onNextPressed : null,
                        label: LocalizedTexts.register.tr(),
                        isLoading: isLoading,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _errorListener(AuthenticationState state) {
    final errorMessage = state.data.error?.message ?? LocalizedTexts.errorSomethingWentWrong;
    context.showErrorBar(
      content: CustomText(errorMessage.tr()),
      position: FlashPosition.top,
    );
  }

  void _onNextPressed() {
    TextInput.finishAutofillContext();

    final physicalData =
        context.read<PhysicalQuestionsBloc>().state.registrationPhysicalQuestionsData;
    final medicalData = context.read<MedicalQuestionsBloc>().state.registrationData;
    final mentalData = context.read<MentalQuestionsBloc>().state.registrationData;
    //Todo put appFlyer ID
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.signUp(
            password: _passwordController.text,
            registrationPhysicalFitnessData: physicalData,
            medicalOnboarding: medicalData,
            mentalHealthTest: mentalData,
          ),
        );
  }

  void _onPasswordChanged(String password, double passwordStrength) {
    _passwordValidationPassed = passwordStrength >= 3 / 4;
    _validateForm();
  }

  void _validateForm() => _formValidationNotifier.value =
      _passwordValidationPassed && _termsAndConditionsAreChecked && _privatePolicyAccepted;

  void _onTermsAndConditionsTap() => _launchInBrowser(termsAndConditionsUrl);

  void _onPrivacyPolicyTap() => _launchInBrowser(privacyPolicyUrl);

  void _showError(BuildContext context) =>
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.tr()));

  Future<void> _launchInBrowser(String url) async {
    final Uri launchUri = Uri.parse(url);

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        _showError(context);
      }
    }
  }

  void _onTermsAndConditionsChanged(bool? value) {
    _termsAndConditionsAreChecked = value!;
    _validateForm();
  }

  void _onPrivacyPolicyChanged(bool? value) {
    _privatePolicyAccepted = value!;
    _validateForm();
  }

  void _onGotAccount(AuthenticationState state) =>
      context.read<RiverBloc>().add(const RiverEvent.getModules());

  void _onRiverModulesLoaded(RiverState state) {
    context.read<NavigationBarBloc>().add(
          const NavigationBarEvent.setBeginningUncompleted(),
        );

    context.router.pushNamed(AppRoutes.waitingForConfirmation);
  }
}
