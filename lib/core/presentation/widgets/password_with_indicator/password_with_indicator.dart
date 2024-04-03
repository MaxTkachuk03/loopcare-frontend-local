import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_strength_indicator.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/reg_exp_utils.dart';

class PasswordWithIndicator extends StatefulWidget {
  final TextEditingController controller;
  final AssetImage? prefixIcon;
  final Function(String password, double passwordStrength)? onChange;

  const PasswordWithIndicator({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.onChange,
  });

  @override
  State<PasswordWithIndicator> createState() => _PasswordWithIndicatorState();
}

class _PasswordWithIndicatorState extends State<PasswordWithIndicator> {
  late String _password;
  double _strength = 0;
  String? _displayText;

  double estimateBruteforceStrength(String password) {
    double strength = 0;

    if (_password.length < 8 || password.isEmpty) {
      return 0.0;
    }

    if (_password.length > 24) {
      return -0.0;
    }

    if (RegExp(RegExpUtils.digitsReg).hasMatch(password)) {
      strength += 1 / 3;
    }

    if (RegExp(RegExpUtils.capitalLetterReg).hasMatch(password)) {
      strength += 1 / 3;
    }

    if (RegExp(RegExpUtils.specialCharactersReg).hasMatch(password)) {
      strength += 1 / 3;
    }

    return strength;
  }

  String getStrengthText(double strength) {
    String retText = '';

    if (strength == 0) {
      if (_password.length < 8 || _password.isEmpty) {
        retText = LocalizedTexts.passwordStrengthToShort.tr();
      } else if (_password.length > 24) {
        retText = LocalizedTexts.passwordStrengthToLong.tr();
      }
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

    widget.onChange?.call(value, _strength);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField.createPassword(
          controller: widget.controller,
          onChanged: _checkPassword,
        ),
        if (_displayText != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              PasswordStrengthIndicator(strength: _strength),
              const SizedBox(height: 8.0),
              CustomText.w600(_displayText!, style: context.textTheme.bodySmall),
            ],
          ),
        const SizedBox(height: 8.0),
        Column(
          children: [
            BulletListItem(
              text: CustomText.w400(LocalizedTexts.passwordValidationRule1.tr(),
                  style: context.textTheme.bodySmall),
              bulletSize: 18,
            ),
            BulletListItem(
              text: CustomText.w400(LocalizedTexts.passwordValidationRule2.tr(),
                  style: context.textTheme.bodySmall),
              bulletSize: 18,
            ),
            BulletListItem(
              text: CustomText.w400(LocalizedTexts.passwordValidationRule3.tr(),
                  style: context.textTheme.bodySmall),
              bulletSize: 18,
            ),
            BulletListItem(
              text: CustomText.w400(LocalizedTexts.passwordValidationRule4.tr(),
                  style: context.textTheme.bodySmall),
              bulletSize: 18,
            )
          ],
        ),
      ],
    );
  }
}
