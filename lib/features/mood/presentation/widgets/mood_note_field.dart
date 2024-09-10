import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';

class MoodNoteField extends StatelessWidget {
  final MoodController controller;
  final bool readOnly;

  const MoodNoteField({super.key, required this.controller, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: controller.noteFieldKey,
      controller: controller.noteController,
      keyboardType: TextInputType.multiline,
      maxLength: 300,
      minLines: 8,
      maxLines: 50,
      readOnly: readOnly,
      hintText: LocalizedTexts.yourNote.tr(),
    );
  }
}
