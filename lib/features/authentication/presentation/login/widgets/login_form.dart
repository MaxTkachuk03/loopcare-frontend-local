import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
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
  bool _isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
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
          listener: _navigationListener,
        ),
      ],
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: Column(
          children: [
            CustomTextField.email(controller: _emailController),
            const SizedBox(height: 12.0),
            CustomTextField.password(controller: _passwordController),
            const SizedBox(height: 40.0),
            CustomElevatedButton.blueFullWidth(
              onPressed: _isDisabled ? null : _onLogin,
              label: LocalizedTexts.login,
            ),
          ],
        ),
      ),
    );
  }

  _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight() &&
        LoginPassword.create(_passwordController.text).isRight();

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  _onLogin() {
    context.read<AuthenticationCubit>().login(
          _emailController.text,
          _passwordController.text,
        );
  }

  void _errorListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        final error = state.error;
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
          MixpanelEventService.instance.track(
            AppMixpanelEvents.loginFail,
            {
              'userId': state.id,
              'email': state.email,
              'message': errorMessage,
            },
          );
        }
      },
    );
  }

  void _navigationListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      authenticated: (state) {
        const route = HomeRoute();
        MixpanelEventService.instance.track(
          AppMixpanelEvents.loginSuccess,
          {
            'userId': state.account.id,
            'email': state.account.email,
            'nextRoute': route.toString(),
          },
        );
        context.router.replaceAll([route]);
      },
    );
  }
}
