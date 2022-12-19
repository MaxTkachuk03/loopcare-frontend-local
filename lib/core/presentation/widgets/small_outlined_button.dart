import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SmallOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SmallOutlinedButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: OutlinedButton(
        onPressed: onPressed,
        style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          minimumSize: MaterialStateProperty.all(
            const Size(
              0,
              32,
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(width: 1.0, color: AppColors.yellowLight),
          ),
          textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodyText2),
        ),
        child: Text(LocalizedTexts.moreInfo.tr()),
      ),
    );
  }
}
