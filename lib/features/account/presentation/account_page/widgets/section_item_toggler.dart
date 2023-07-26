import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionItemToggler extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?) onPressHandler;

  const SectionItemToggler({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressHandler,
  }) : super(key: key);

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
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ).tr(),
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
