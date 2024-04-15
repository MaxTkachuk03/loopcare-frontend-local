import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';

const accountNotFound = 'account_not_found';
const emailOrPasswordAreIncorrect = 'email_or_password_are_incorrect';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formValidationNotifier = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _formValidationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _navigationListener,
      builder: (context, state) {
        return AutofillGroup(
          child: Form(
            key: _formKey,
            onChanged: _onChangedForm,
            child: Column(
              children: [
                CustomTextField.loginEmail(
                  key: const ValueKey('login_email_text_field'),
                  controller: _emailController,
                ),
                const SizedBox(height: 12.0),
                CustomTextField.password(
                  key: const ValueKey('login_password_text_field'),
                  controller: _passwordController,
                ),
                const SizedBox(height: 40.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _formValidationNotifier,
                  builder: (context, isValid, _) {
                    return CustomElevatedButton.blueFullWidth(
                      key: const ValueKey('login_button'),
                      onPressed: isValid ? _onLogin : null,
                      label: LocalizedTexts.login.tr(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight() &&
        LoginPassword.create(_passwordController.text).isRight();

    _formValidationNotifier.value = isValidForm;
  }

  _onLogin() {
    TextInput.finishAutofillContext();

    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.login(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _navigationListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      authenticated: (state) {
        String route = AppRoutes.home;
        //Todo hide subscription flow LOOPCARE-2197
        if ((state.data.account?.hasActiveSubscription ?? false) || !kIsProd) {
          route = AppRoutes.home;
        } else {
          route = AppRoutes.subscription;
        }

        pushNamedAndClearStack(context, route);
      },
      guest: (state) {
        final error = state.data.error;
        if (error != null) {
          final errorMessage = error.maybeMap(
            notFound: (error) {
              return error.maybeMap(
                notFound: (e) {
                  final message = e.error.message;
                  return message == accountNotFound
                      ? LocalizedTexts.emailOrPasswordAreIncorrect.tr()
                      : LocalizedTexts.somethingIsIncorrect.tr();
                },
                orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
              );
            },
            badRequest: (error) {
              final message = error.error.message;

              return message == emailOrPasswordAreIncorrect
                  ? LocalizedTexts.emailOrPasswordAreIncorrect.tr()
                  : LocalizedTexts.somethingIsIncorrect.tr();
            },
            orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
          );
          context.showError(content: Text(errorMessage));
        }
      },
    );
  }

  Future<dynamic> pushNamedAndClearStack(BuildContext context, String path) {
    context.router.popUntilRoot();
    return context.router.replaceNamed(path);
  }
}
