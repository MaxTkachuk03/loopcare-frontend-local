import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionItemToggler extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?) onPressHandler;

  const SectionItemToggler({
    super.key,
    required this.title,
    required this.value,
    required this.onPressHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: value,
          activeColor: AppColors.blueDark,
          onChanged: onPressHandler,
        )
      ],
    );
  }
}
