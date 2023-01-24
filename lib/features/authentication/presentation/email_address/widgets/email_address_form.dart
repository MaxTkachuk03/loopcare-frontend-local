import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_bad_request.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/email_validator.dart';

const userAlreadyExists = 'user_with_this_email_already_exists';

class EmailAddressForm extends StatefulWidget {
  const EmailAddressForm({Key? key}) : super(key: key);

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
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _errorListener,
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: Column(
          children: [
            Field(
                controller: _emailController,
                hintText: LocalizedTexts.yourEmail.tr(),
                validator: emailValidator()),
            const SizedBox(
              height: 22.0,
            ),
            CheckboxFormField(
              text: RichText(
                maxLines: 2,
                overflow: TextOverflow.visible,
                text: TextSpan(
                  text: '${LocalizedTexts.iHaveReadAndAcceptThe.tr()} ',
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onTermsAndConditionsTap,
                      text: LocalizedTexts.termsAndConditions.tr(),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
              onPressed: _isDisabled ? null : _onRegisterPressed,
              child: Text(LocalizedTexts.register.tr()),
            ),
          ],
        ),
      ),
    );
  }

  _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight() &&
        termsAndConditionsAreChecked;

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _onRegisterPressed() {
    context.read<AuthenticationCubit>().signUp(_emailController.text);
  }

  void _onTermsAndConditionsTap() {}

  void _onTermsAndConditionsChanged(bool? value) {
    setState(() {
      termsAndConditionsAreChecked = value ?? false;
    });
  }

  void _errorListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        final error = state.error;
        if (error != null) {
          error.mapOrNull(
            badRequest: (error) {
              final errorMessage = error.maybeMap(
                badRequest: (error) {
                  final message = SignUpBadRequest.fromJson(
                    error.error.response?.data ?? {},
                  ).message;

                  if (message == userAlreadyExists) {
                    setState(() {
                      emailErrorText = LocalizedTexts.emailAlreadyTaken.tr();
                    });
                  }

                  return LocalizedTexts.somethingIsIncorrect.tr();
                },
                orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
              );

              showAppSnackBar(context: context, text: errorMessage);
            },
          );
        }
      },
    );
  }
}
