import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/login_password_validator.dart';

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
          error.mapOrNull(
            badRequest: (error) {
              final errorMessage = error.maybeMap(
                badRequest: (error) {
                  // TODO: add error for incorrect password or email
                  // final message = SignUpBadRequest.fromJson(
                  //   error.error.response?.data ?? {},
                  // ).message;

                  return LocalizedTexts.somethingIsIncorrect.tr();
                },
                orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
              );

              showAppSnackBar(
                context: context,
                text: errorMessage,
                background: AppColors.red,
              );
            },
          );
        }
      },
    );
  }
}
