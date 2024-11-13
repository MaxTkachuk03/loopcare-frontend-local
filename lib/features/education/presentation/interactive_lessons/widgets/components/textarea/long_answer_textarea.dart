import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/local_storage.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LongAnswerTextarea extends StatefulWidget {
  const LongAnswerTextarea({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.isClickedHandler,
  });

  final InteractiveLessonChunkComponentTextField component;
  final RiverModuleStreamType lessonStreamType;
  final Function(bool isClicked) isClickedHandler;

  @override
  State<LongAnswerTextarea> createState() => _LongAnswerTextareaState();
}

class _LongAnswerTextareaState extends State<LongAnswerTextarea> {
  // ContentSelectAnswer? _selectedAnswer;
  String? text = '';
  // late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  //   _controller.text = text ?? '';
  // }

  void _onChangeHandler(String e) {
    setState(() {
      text = e;
    });
    // localStorage.setValue(InteractiveLessonLocalStorageKeys.shortAnswerDraftKey, e);
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
            height: 330,
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
                // Container(
                //   decoration: const BoxDecoration(border:
                //   Border(
                //       bottom: BorderSide(color: widget,
                //       width: 1.0,
                //       style: BorderStyle.solid))),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         CustomText(
                //           'timeDate',
                //           style: context.textTheme.bodyMedium!
                //               .copyWith(fontWeight: FontWeight.w700),),
                //         IconButton(
                //           onPressed: (){},
                //           icon: SvgPicture.asset('assets/icons/edit_pencil.svg'),
                //           iconSize: 44,)
                //       ],
                //     ),
                // ),

                TextField(
                  clipBehavior: Clip.hardEdge,
                  onChanged: _onChangeHandler,
                  maxLines: 5, //or null
                  decoration: const InputDecoration(
                      // focusedBorder: ,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Text here",
                      hintStyle: TextStyle(color: AppColors.black),
                      fillColor: AppColors.greenLightest,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20)),
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid))),
                    child: OutlinedButton(onPressed: () {}, child: Text(''))),
              ],
            ))
      ],
    );
  }
}
