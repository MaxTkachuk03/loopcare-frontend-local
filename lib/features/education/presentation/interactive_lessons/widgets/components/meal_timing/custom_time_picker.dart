import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_text_area_history.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.secondTime,
    required this.id,
    required this.index,
    required this.mealName,
    required this.category,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
    required this.componentHistory,
  });

  final DateTime initialTime;
  final DateTime secondTime;
  final int id;
  final int index;
  final List<InteractiveLessonHistory> componentHistory;
  final String mealName;
  final String category;
  final InteractiveLessonChunkComponentMealTiming component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  DateTime newTime = DateTime.now();

  void _onSaveHandler(DateTime updateAt) {
    widget.componentHistory[widget.index] = InteractiveLessonHistory(
        mealItemId: widget.id,
        id: widget.id,
        text: widget.category.toLowerCase().split('&').last.trim(),
        updatedAt: updateAt,
        createdAt: widget.secondTime);

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(
            history: widget.componentHistory, type: widget.component.type.name),
        widget.component);
  }

  @override
  Widget build(BuildContext context) {
    print("id: ${widget.category.toLowerCase().split('&').last.trim()}");
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Center(
          child: Container(
            height: height / 2.5,
            width: width / 1.15,
            padding:
                const EdgeInsets.symmetric(vertical: 26.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: AppColors.bgGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  LocalizedTexts.selectYourTime.tr(),
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CupertinoDatePicker(
                        initialDateTime: widget.initialTime,
                        onDateTimeChanged: (DateTime value) {
                          newTime = value;
                        },
                        mode: CupertinoDatePickerMode.time,
                      ),
                      Container(
                        height: 35,
                        width: width / 1.15,
                        decoration: BoxDecoration(
                          color: AppColors.greenMid.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    ],
                  ),
                ),
                ContinueBtn(
                    bottom: 0,
                    onPressed: () {
                      _onSaveHandler(newTime);

                      context.router.maybePop(context);
                    },
                    isDisable: false),
              ],
            ),
          ),
        );
      },
    );
  }
}
