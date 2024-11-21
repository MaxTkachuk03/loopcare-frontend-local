import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/local_storage.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

class ShortAnswerTextField extends StatefulWidget {
  const ShortAnswerTextField({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.isClickedHandler,
  });

  final InteractiveLessonChunkComponentTextField component;
  final RiverModuleStreamType lessonStreamType;
  final Function(bool isClicked) isClickedHandler;

  @override
  State<ShortAnswerTextField> createState() => _ShortAnswerTextFieldState();
}

class _ShortAnswerTextFieldState extends State<ShortAnswerTextField> {
  // ContentSelectAnswer? _selectedAnswer;
  String? text = '';
  // final LocalStorage localStorage = LocalStorage();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // _initializeLocalStorage();
    _controller = TextEditingController();
    _controller.text = text ?? '';
  }

  // Future<void> _initializeLocalStorage() async {
  //   await localStorage.init();
  //   setState(() {
  //     text = localStorage.getValue<String>(InteractiveLessonLocalStorageKeys.shortAnswerDraftKey);
  //   });
  //
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
          label: 'Short answer',
          lessonStreamType: widget.lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(
          content.question,
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        TextField(
          clipBehavior: Clip.hardEdge,
          onChanged: _onChangeHandler,
          controller: _controller,
        )
      ],
    );
  }
}
