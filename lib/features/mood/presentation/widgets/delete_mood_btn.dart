import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button_with_icon.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class DeleteMoodBtn extends StatelessWidget {
  final void Function() onPress;

  const DeleteMoodBtn({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButtonWithIcon.orangeSmall(
      label: LocalizedTexts.deleteMood.tr(),
      icon: const ImageIcon(AppIcons.delete),
      onPressed: onPress,
    );
  }
}
