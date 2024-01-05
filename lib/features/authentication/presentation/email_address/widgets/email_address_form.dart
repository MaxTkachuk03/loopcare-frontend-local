import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';

const accountAlreadyExists = 'account_with_this_email_already_exists';

class EmailAddressForm extends StatefulWidget {
  const EmailAddressForm({super.key});

  @override
  State<EmailAddressForm> createState() => _EmailAddressFormState();
}

class _EmailAddressFormState extends State<EmailAddressForm> {
  String? emailErrorText;
  bool termsAndConditionsAreChecked = false;
  bool _isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
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
            Field(
              controller: _emailController,
              hintText: LocalizedTexts.yourEmail.tr(),
              validator: emailValidator(),
              errorText: emailErrorText,
              keyboardType: TextInputType.emailAddress,
              onChanged: _onEmailChanged,
            ),
            const SizedBox(
              height: 22.0,
            ),
            CheckboxFormField(
              errorText: LocalizedTexts.pleaseAcceptTOC.translation,
              text: RichText(
                maxLines: 2,
                overflow: TextOverflow.visible,
                text: TextSpan(
                  text: '${LocalizedTexts.iHaveReadAndAcceptThe.tr()} ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = _onTermsAndConditionsTap,
                      text: LocalizedTexts.termsAndConditions.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ],
                ),
              ),
              onChanged: _onTermsAndConditionsChanged,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isDisabled ? null : () => _onRegisterPressed(context),
              child: Text(LocalizedTexts.register.tr()),
            ),
          ],
        ),
      ),
    );
  }

  _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight() && termsAndConditionsAreChecked;

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _onRegisterPressed(BuildContext context) {
    setState(() {
      emailErrorText = null;
    });
    final registrationPhysicalFitnessData =
        context.read<PhysicalFitnessBloc>().state.registrationPhysicalFitnessData;

    final mentalHealthTest = context.read<MentalHealthBloc>().state.data.answers;

    context.read<AuthenticationCubit>().signUp(
          _emailController.text,
          registrationPhysicalFitnessData,
          MentalHealthTestAnswer(answers: mentalHealthTest),
        );
  }

  void _onTermsAndConditionsTap() {}

  void _onTermsAndConditionsChanged(bool? value) {
    setState(() {
      termsAndConditionsAreChecked = value ?? false;
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
          error.mapOrNull(
            badRequest: (error) {
              final errorMessage = error.maybeMap(
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
              );
              context.showError(content: Text(errorMessage));
            },
          );
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
