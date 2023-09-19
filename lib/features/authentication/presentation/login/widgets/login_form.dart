import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/login_password_validator.dart';

const accountNotFound = 'account_not_found';
const emailOrPasswordAreIncorrect = 'email_or_password_are_incorrect';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

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
    super.dispose();

    _passwordController.dispose();
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
          listener: _navigationListener,
        ),
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
              prefixIcon: AppIcons.iconMail,
              keyboardType: TextInputType.emailAddress,
              contentPadding: const EdgeInsets.only(bottom: 0.0, top: 15.0),
            ),
            const SizedBox(height: 10.0),
            Field(
              hintText: LocalizedTexts.yourPassword.tr(),
              prefixIcon: AppIcons.iconLock,
              isToggleEye: true,
              obscureText: true,
              controller: _passwordController,
              validator: loginPasswordValidator(),
              contentPadding: const EdgeInsets.only(bottom: 0.0, top: 15.0),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _isDisabled ? null : _onLogin,
              child: Text(LocalizedTexts.loginBtn.tr()),
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

          showAppSnackBar(
            context: context,
            text: errorMessage,
            background: AppColors.red,
            textColor: Colors.white,
          );
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
        final route = state.isPreferencesComplete ? const HomeRoute() : const PreferencesOverviewRoute();
        MixpanelEventService.instance.track(
          AppMixpanelEvents.loginSuccess,
          {
            'userId': state.account.id,
            'email': state.account.email,
            'next_rout': route,
          },
        );
        context.router.replaceAll([route]);
      },
    );
  }
}
