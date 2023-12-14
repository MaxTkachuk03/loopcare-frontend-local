import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_option.dart';

class QuizzesController {
  QuizzesController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> answerTextFieldKey = GlobalKey<FormFieldState<String>>();
  final TextEditingController answerTextController = TextEditingController();

  final FocusNode answerTextFocusNode = FocusNode();

  AutovalidateMode answerTextAutoValidateMode = AutovalidateMode.disabled;

  ValueNotifier<bool> isCorrect = ValueNotifier(false);
  ValueNotifier<bool> isEnableSend = ValueNotifier(false);
  ValueNotifier<LessonQuestionOption?> selectLessonValue = ValueNotifier(null);
  ValueNotifier<List<int>> selectOptionValues = ValueNotifier([]);
  ValueNotifier<int?> selectScaleValue = ValueNotifier(null);

  bool get isAnswerTextValid => isEnableSend.value = answerTextFieldKey.currentState?.isValid ?? false;

  bool get isOpenTextValid => answerTextController.value.text.trim().isNotEmpty;

  bool get isFormValid => isCorrect.value = (selectLessonValue.value?.isCorrect ?? false);

  bool get isOptionChoiceValid => selectOptionValues.value.isNotEmpty;

  bool get isScaleChoiceValid => selectScaleValue.value != null;

  void setLessonValue(LessonQuestionOption item) => selectLessonValue.value = item;

  void setOptionValue(List<int> items) => selectOptionValues.value = items;

  void selectOptionValue(int id, {multiSelect = false}) {
    if (multiSelect) {
      if (selectOptionValues.value.contains(id)) {
        selectOptionValues.value.remove(id);
      } else {
        selectOptionValues.value.add(id);
      }
    } else {
      selectOptionValues.value = [id];
    }
  }

  void setScaleValue(int value) => selectScaleValue.value = value;

  void addFocusNodeListeners() {
    answerTextFocusNode.addListener(() {
      if (!answerTextFocusNode.hasFocus) {
        answerTextController.text = answerTextController.value.text.trim();
        answerTextFieldKey.currentState?.validate();
        answerTextAutoValidateMode = AutovalidateMode.always;
      }
    });
  }

  void dispose() {
    isCorrect.dispose();

    answerTextController.dispose();
    answerTextFocusNode.dispose();
  }
}
