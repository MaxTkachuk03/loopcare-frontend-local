import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';

class MoodNoteField extends AppLimitTextField {
  MoodNoteField(MoodController controller, bool readOnly, {super.key})
      : super(
          fieldKey: controller.noteFieldKey,
          focusNode: controller.noteFocusNode,
          controller: controller.noteController,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          autovalidateMode: controller.noteAutoValidateMode,
          onChanged: (_) {},
          limitCount: 300,
          minLines: 8,
          linesCount: 50,
          readOnly: readOnly,
          hintText: LocalizedTexts.yourNote.tr(),
        );
}
