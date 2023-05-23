import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_with_indicator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String _password = '';
  String _repeatPassword = '';
  bool _passwordsMatch = true;
  String passwordsNotMatchError = LocalizedTexts.passwordsNotMatch.tr();

  void _onPasswordChanged(String password, double passwordStrength) {
    setState(() {
      _password = password;
      _passwordsMatch = _password == _repeatPassword;
    });
  }

  void _onRepeatPasswordChanged(String repeatPassword) {
    setState(() {
      _repeatPassword = repeatPassword;
      _passwordsMatch = _password == _repeatPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.center,
                        child: AppImages.logoSvgMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        LocalizedTexts.leanOnMe.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                                color: AppColors.blueDark),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        LocalizedTexts.enterNewPassword.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 36.0),
                      PasswordWithIndicator(onChange: _onPasswordChanged),
                      const SizedBox(height: 16.0),
                      Field(
                        hintText: LocalizedTexts.repeatPassword.tr(),
                        prefixIcon: AppIcons.iconLock,
                        isToggleEye: true,
                        obscureText: true,
                        onChanged: _onRepeatPasswordChanged,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      if (!_passwordsMatch)
                        Text(
                          passwordsNotMatchError,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () => _onResetPasswordPressed(),
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.orangeDark),
                            ),
                        child: Text(LocalizedTexts.resetPassword.tr()),
                      ),
                      const SizedBox(height: 23.0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onResetPasswordPressed() {}
}
