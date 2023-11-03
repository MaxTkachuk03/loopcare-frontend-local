import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';

class DeleteMoodBtn extends StatelessWidget {
  final void Function() onPress;

  const DeleteMoodBtn({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return OutlinedRoundedButton(
      text: LocalizedTexts.deleteMood.tr(),
      icon: AppIcons.delete,
      onPressed: onPress,
    );
  }
}
