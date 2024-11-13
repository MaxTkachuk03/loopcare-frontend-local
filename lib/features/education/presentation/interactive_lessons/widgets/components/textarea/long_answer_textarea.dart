import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class LongAnswerTextArea extends StatefulWidget {
  const LongAnswerTextArea(
      {super.key,
      required this.component,
      required this.lessonStreamType,
      required this.onSaveProgress,
      required this.scrollDown});

  final InteractiveLessonChunkComponentTextArea component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;
  final Function() scrollDown;

  @override
  State<LongAnswerTextArea> createState() => _LongAnswerTextAreaState();
}

class _LongAnswerTextAreaState extends State<LongAnswerTextArea> {
  String text = '';
  bool isButtonDisabled = false;
  String successText = '';
  late TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  void _removeFocus() {
    _focusNode.unfocus();
  }

  @override
  void initState() {
    _controller = TextEditingController();

    if (widget.component.progress == null) return;
    text = widget.component.progress!.response!;
    _controller.text = text;
    super.initState();
  }

  void _onChangeHandler(String e) {
    setState(() {
      text = e;
      isButtonDisabled = e.isNotEmpty;
    });
  }

  void _onSaveHandler() {
    setState(() {
      successText = 'Saved';
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(response: text), widget.component);

    _removeFocus();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isButtonDisabled = false;
        successText = "";
      });
    });

    widget.scrollDown();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose(); // Don't forget to dispose of the FocusNode
    super.dispose();
  }

  TextFieldContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: 'Long answer',
          lessonStreamType: widget.lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(
          content.question,
          style: context.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, width: 1.0, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: widget.lessonStreamType.lighterColor,
                              width: 1.0,
                              style: BorderStyle.solid))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'timeDate',
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: AppIcons.editPencil,
                        iconSize: 44,
                      )
                    ],
                  ),
                ),
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  clipBehavior: Clip.hardEdge,
                  onChanged: _onChangeHandler,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Text here",
                      hintStyle: TextStyle(color: AppColors.black),
                      fillColor: AppColors.greenLightest,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 20)),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: widget.lessonStreamType.lighterColor,
                              width: 1.0,
                              style: BorderStyle.solid))),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: text.isEmpty || !isButtonDisabled
                            ? null
                            : _onSaveHandler,
                        alignment: Alignment.center,
                        disabledColor: AppColors.greyLighter,
                        style: ButtonStyle(
                            iconColor: WidgetStateProperty.all(
                                widget.lessonStreamType.regularColor)),
                        color: widget.lessonStreamType.regularColor,
                        icon: AppIcons.interactiveLessonCheckmark(
                            isButtonDisabled,
                            widget.lessonStreamType.regularColor,
                            AppColors.greyLighter),
                      ),
                      if (successText.isNotEmpty) Text(successText)
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
