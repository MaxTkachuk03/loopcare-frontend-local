import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_emotion.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_food.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_where.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_with_who.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/utils.dart';

class MoodController {
  MoodController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> noteFieldKey = GlobalKey<FormFieldState<String>>();
  final TextEditingController noteController = TextEditingController();

  ValueNotifier<bool> isValid = ValueNotifier(false);
  ValueNotifier<MoodPickerListItem?> moodValue = ValueNotifier(null);
  ValueNotifier<DateTime?> timeValue = ValueNotifier(null);
  ValueNotifier<List<MoodWithWho>> withWhoValues = ValueNotifier([]);
  ValueNotifier<List<MoodWhere>> whereValues = ValueNotifier([]);
  ValueNotifier<List<MoodFood>> foodValues = ValueNotifier([]);
  ValueNotifier<List<MoodEmotion>> emotionValues = ValueNotifier([]);

  bool get isFormValid => isValid.value =
      noteController.text.isNotEmpty && moodValue.value != null && timeValue.value != null;

  void setMoodInitialValues(Mood value) {
    final moodValue = MoodUtils.getMoodByValue(value.scale);
    final moodTimeValue = value.time.toLocal();
    final moodEmotionValue = value.emotion.map((e) => MoodEmotion.getValueByString(e)).toList();
    final moodWithWhoValue = value.person.map((e) => MoodWithWho.getValueByString(e)).toList();
    final moodWhereValue = value.location.map((e) => MoodWhere.getValueByString(e)).toList();
    final moodFoodValue = value.food.map((e) => MoodFood.getValueByString(e)).toList();

    setMoodValue(moodValue);
    setTimeValue(moodTimeValue);
    setEmotionValue(moodEmotionValue);
    setWithWhoValue(moodWithWhoValue);
    setWhereValue(moodWhereValue);
    setFoodValue(moodFoodValue);
    setNoteValue(value.note);
  }

  void setNoteValue(String item) => noteController.text = item;

  void setMoodValue(MoodPickerListItem item) => moodValue.value = item;

  void setTimeValue(DateTime item) => timeValue.value = item;

  void setWithWhoValue(List<MoodWithWho> list) => withWhoValues.value = list;

  void setWhereValue(List<MoodWhere> list) => whereValues.value = list;

  void setFoodValue(List<MoodFood> list) => foodValues.value = list;

  void setEmotionValue(List<MoodEmotion> list) => emotionValues.value = list;

  int get moodScaleValue => moodValue.value?.value ?? 0;

  List<String> get moodWithWhoValue => withWhoValues.value.map((e) => e.value).toList();

  List<String> get moodWhereValue => whereValues.value.map((e) => e.value).toList();

  List<String> get moodFoodValue => foodValues.value.map((e) => e.value).toList();

  List<String> get moodEmotionString => emotionValues.value.map((e) => e.value).toList();

  DateTime get loggingDate => timeValue.value ?? DateTime.now();

  void dispose() {
    noteController.dispose();
    moodValue.dispose();
    timeValue.dispose();
    withWhoValues.dispose();
    whereValues.dispose();
    foodValues.dispose();
    emotionValues.dispose();
    isValid.dispose();
  }
}
