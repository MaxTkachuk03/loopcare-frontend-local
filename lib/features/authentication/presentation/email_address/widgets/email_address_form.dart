import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/response_error_const.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailAddressForm extends StatefulWidget {
  const EmailAddressForm({super.key});

  @override
  State<EmailAddressForm> createState() => _EmailAddressFormState();
}

class _EmailAddressFormState extends State<EmailAddressForm> {
  final _formKey = GlobalKey<FormState>();

  String? emailErrorText;
  bool _isDisabled = true;

  bool termsAndConditionsAreChecked = false;
  bool privatePolicyAccepted = false;

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: _errorListener,
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) => previous is EmailAddress && current is WaitedForConfirmation,
          listener: _navigationListener,
        )
      ],
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: Column(
          children: [
            CustomTextField.email(
              controller: _emailController,
              errorText: emailErrorText,
              onChanged: _onEmailChanged,
            ),
            const SizedBox(height: 8.0),
            CheckboxFormField(
              errorText: '${LocalizedTexts.pleaseAcceptTOC.tr()}.',
              text: RichText(
                maxLines: 2,
                overflow: TextOverflow.visible,
                text: TextSpan(
                  text: '${LocalizedTexts.iAcceptThe.tr()} ',
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = _onTermsAndConditionsTap,
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
            const SizedBox(height: 16.0),
            CustomElevatedButton.blueFullWidth(
              onPressed: _isDisabled ? null : _onRegisterPressed,
              label: LocalizedTexts.register,
            ),
          ],
        ),
      ),
    );
  }

  _onChangedForm() {
    final isValidForm =
        Email.create(_emailController.text).isRight() && termsAndConditionsAreChecked && privatePolicyAccepted;

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _onRegisterPressed() {
    setState(() {
      emailErrorText = null;
    });
    final registrationPhysicalFitnessData =
        context.read<PhysicalFitnessBloc>().state.registrationPhysicalFitnessData;

    final mentalHealthTest = context.read<MentalHealthBloc>().state.data.answers;
    final medicalOnboardingData = context.read<MedicalFitnessBloc>().state.data;

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userEmail,
      parameters: {
        CustomDefinitions.value: _emailController.text,
        CustomDefinitions.confirmed: 'false',
      },
    );

    context.read<AuthenticationCubit>().signUp(
          _emailController.text,
          registrationPhysicalFitnessData,
          MentalHealthTestAnswer(answers: mentalHealthTest),
          medicalOnboardingData.registrationData(),
        );
  }

  void _onTermsAndConditionsTap() {
    _launchInBrowser(termsAndConditionsUrl);
  }

  void _onPrivacyPolicyTap() {
    _launchInBrowser(privacyPolicyUrl);
  }

  void _showError(BuildContext context) =>
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.translation));

  Future<void> _launchInBrowser(String url) async {
    final Uri launchUri = Uri.parse(url);

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) _showError(context);
    }
  }

  void _onTermsAndConditionsChanged(bool? value) {
    setState(() {
      termsAndConditionsAreChecked = value!;
    });
  }

  void _onPrivacyPolicyChanged(bool? value) {
    setState(() {
      privatePolicyAccepted = value!;
    });
  }

  void _onEmailChanged(String value) {
    if (emailErrorText == null) return;

    setState(() {
      emailErrorText = null;
    });
  }

  void _errorListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      emailAddress: (state) {
        final error = state.error;
        if (error != null) {
          final errorMessage = error.mapOrNull(
            badRequest: (error) => error.maybeMap(
                badRequest: (error) {
                  final message = error.error.message;

                  if (message == accountAlreadyExists) {
                    setState(() {
                      emailErrorText = LocalizedTexts.emailAlreadyTaken.tr();
                    });
                  }
                  return LocalizedTexts.somethingIsIncorrect.tr();
                },
                orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
              ),
            forbidden: (error) => (error.error.message != null)
                  ? error.error.message!
                  : LocalizedTexts.somethingIsIncorrect.tr(),
          );
          if (errorMessage != null) {
            context.showError(content: Text(errorMessage));
          }
        }
      },
    );
  }

  void _navigationListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      waitedForConfirmation: (state) {
        context.router.pushNamed(AppRoutes.waitingForConfirmation);
      },
    );
  }
}
