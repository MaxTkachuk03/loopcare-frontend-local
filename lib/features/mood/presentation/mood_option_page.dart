import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_emotion.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_food.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_option_page_mode.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_where.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_with_who.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_emotion_option.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_food_options.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_time_option.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_where_options.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_with_who_option.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class MoodOptionPage extends StatefulWidget {
  final MoodOptionPageMode mode;
  final MoodController controller;

  const MoodOptionPage({
    super.key,
    required this.mode,
    required this.controller,
  });

  @override
  State<MoodOptionPage> createState() => _MoodOptionPageState();
}

class _MoodOptionPageState extends State<MoodOptionPage> {
  late DateTime _time;
  List<MoodWithWho> _withWhoValues = [];
  List<MoodWhere> _whereValues = [];
  List<MoodFood> _foodValues = [];
  List<MoodEmotion> _emotionValues = [];

  @override
  void initState() {
    _time = widget.controller.timeValue.value ?? DateTime.now();
    _withWhoValues = [...widget.controller.withWhoValues.value];
    _whereValues = [...widget.controller.whereValues.value];
    _foodValues = [...widget.controller.foodValues.value];
    _emotionValues = [...widget.controller.emotionValues.value];

    super.initState();
  }

  String get _title => widget.mode.map(
        emotion: (_) => LocalizedTexts.moodOptionPageEmotionTitle.tr(),
        time: (_) => LocalizedTexts.time.tr(),
        withWho: (_) => LocalizedTexts.withWho.tr(),
        where: (_) => LocalizedTexts.where.tr(),
        food: (_) => LocalizedTexts.food.tr(),
      );

  Widget get content => widget.mode.map(
        emotion: (_) => MoodEmotionOption(onChange: _onEmotionChangeHandler, selectedValues: _emotionValues),
        time: (_) => MoodTimeOption(onChange: _onTimeChangeHandler, initialValue: _time),
        withWho: (_) => MoodWithWhoOption(onChange: _onWithWhoChangeHandler, selectedValues: _withWhoValues),
        where: (_) => MoodWhereOptions(onChange: _onWhereChangeHandler, selectedValues: _whereValues),
        food: (_) => MoodFoodOptions(onChange: _onFoodChangeHandler, selectedValues: _foodValues),
      );

  void _onTimeChangeHandler(DateTime value) {
    _time = value;
    setState(() {});
  }

  void _onWithWhoChangeHandler(MoodWithWho value) {
    _withWhoValues.contains(value) ? _withWhoValues.remove(value) : _withWhoValues.add(value);

    setState(() {});
  }

  void _onWhereChangeHandler(MoodWhere value) {
    _whereValues.contains(value) ? _whereValues.remove(value) : _whereValues.add(value);

    setState(() {});
  }

  void _onFoodChangeHandler(MoodFood value) {
    _foodValues.contains(value) ? _foodValues.remove(value) : _foodValues.add(value);

    setState(() {});
  }

  void _onEmotionChangeHandler(MoodEmotion value) {
    if (_emotionValues.length == 3 && !_emotionValues.contains(value)) return;

    _emotionValues.contains(value) ? _emotionValues.remove(value) : _emotionValues.add(value);

    setState(() {});
  }

  void _onConfirmHandler() {
    widget.mode.map(
      emotion: (_) => widget.controller.setEmotionValue(_emotionValues),
      time: (_) => widget.controller.setTimeValue(_time),
      withWho: (_) => widget.controller.setWithWhoValue(_withWhoValues),
      where: (_) => widget.controller.setWhereValue(_whereValues),
      food: (_) => widget.controller.setFoodValue(_foodValues),
    );

    widget.controller.isFormValid;

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(title: _title, leading: const BackButtonHexagon()),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [const SizedBox(height: 30.0), content]),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _onConfirmHandler,
                      child: const Text(LocalizedTexts.confirm).tr(),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
