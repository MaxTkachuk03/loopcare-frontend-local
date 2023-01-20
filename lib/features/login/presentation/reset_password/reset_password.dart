import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/login/presentation/reset_password/widgets/passworg_strength_indicator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late String _password;
  double _strength = 0;
  String? _displayText;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp specCharReg = RegExp(r'.*[\-_!?].*');

  double estimateBruteforceStrength(String password) {
    double strength = 0;

    if (password.isEmpty) return 0.0;

    if (_password.length < 6) {
      return 0;
    }

    if (numReg.hasMatch(password)) {
      strength += 1 / 3;
    }
    if (letterReg.hasMatch(password)) {
      strength += 1 / 3;
    }
    if (specCharReg.hasMatch(password)) {
      strength += 1 / 3;
    }

    return strength;
  }

  String getStrengthText(double strength) {
    String retText = '';

    if (strength == 0) {
      retText = LocalizedTexts.passwordStrengthToShort.tr();
    } else if (strength <= 1 / 3) {
      retText = LocalizedTexts.passwordStrengthNotSecure.tr();
    } else if (strength <= 2 / 3) {
      retText = LocalizedTexts.passwordStrengthMiddle.tr();
    } else {
      retText = LocalizedTexts.passwordStrengthNice.tr();
    }

    return retText;
  }

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = null;
      });
    } else {
      setState(() {
        _strength = estimateBruteforceStrength(_password);
        _displayText = getStrengthText(_strength);
      });
    }
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                            color: AppColors.blueDark),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        LocalizedTexts.enterNewPassword.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 36.0),
                      Field(
                        hintText: LocalizedTexts.yourPassword.tr(),
                        prefixIcon: AppIcons.iconLock,
                        isToggleEye: true,
                        obscureText: true,
                        onChanged: (v) => _checkPassword(v),
                      ),
                      const SizedBox(height: 16.0),
                      PassworgStrengthIndicator(strength: _strength),
                      if (_displayText != null) const SizedBox(height: 8.0),
                      if (_displayText != null) Text(_displayText!),
                      const SizedBox(height: 16.0),
                      Field(
                        hintText: LocalizedTexts.repeatPassword.tr(),
                        prefixIcon: AppIcons.iconLock,
                        isToggleEye: true,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: _onContinuePressed,
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.blueDark),
                            ),
                        child: Text(LocalizedTexts.continueBtn.tr()),
                      ),
                      const SizedBox(height: 23.0),
                      Text(
                        LocalizedTexts.returnToLoginScreen.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
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

  void _onContinuePressed() {}
}
