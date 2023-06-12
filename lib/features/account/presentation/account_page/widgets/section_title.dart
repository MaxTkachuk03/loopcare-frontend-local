import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 18.0),
        ).tr(),
        const SizedBox(height: 9.0),
        const Divider(height: 1.0, color: AppColors.profileDivider),
        const SizedBox(height: 22.0),
      ],
    );
  }
}
