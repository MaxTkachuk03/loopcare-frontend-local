import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_strength_indicator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/reg_exp_utils.dart';

class PasswordWithIndicator extends StatefulWidget {
  final TextEditingController? controller;
  final AssetImage? prefixIcon;
  final Function(String password, double passwordStrength)? onChange;

  const PasswordWithIndicator({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.onChange,
  }) : super(key: key);

  @override
  State<PasswordWithIndicator> createState() => _PasswordWithIndicatorState();
}

class _PasswordWithIndicatorState extends State<PasswordWithIndicator> {
  late String _password;
  double _strength = 0;
  String? _displayText;

  double estimateBruteforceStrength(String password) {
    double strength = 0;

    if (_password.length < 6 || password.isEmpty) {
      return 0.0;
    }

    if (RegExp(RegExpUtils.digitsReg).hasMatch(password)) {
      strength += 1 / 3;
    }
    if (RegExp(RegExpUtils.letterReg).hasMatch(password)) {
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

    widget.onChange?.call(value, _strength);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Field(
          controller: widget.controller,
          hintText: LocalizedTexts.yourPassword.tr(),
          prefixIcon: widget.prefixIcon,
          isToggleEye: true,
          obscureText: true,
          onChanged: _checkPassword,
        ),
        if (_displayText != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              PasswordStrengthIndicator(strength: _strength),
              const SizedBox(height: 8.0),
              Text(_displayText!),
            ],
          ),
      ],
    );
  }
}
