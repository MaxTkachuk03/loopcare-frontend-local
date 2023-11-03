import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';
import 'package:loopcare_frontend/features/mood/presentation/validators/mood_note_validator.dart';

class MoodNoteField extends AppLimitTextField {
  MoodNoteField(MoodController controller, {super.key})
      : super(
          fieldKey: controller.noteFieldKey,
          focusNode: controller.noteFocusNode,
          controller: controller.noteController,
          validator: validateMoodNoteField,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          autovalidateMode: controller.noteAutoValidateMode,
          onChanged: (_) {},
          limitCount: 300,
          minLines: 8,
          linesCount: 50,
        );
}
