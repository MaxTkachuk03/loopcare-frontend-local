import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_text_area_history.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/textarea/long_answer_textarea_item.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class LongAnswerTextArea extends StatefulWidget {
  const LongAnswerTextArea({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  final InteractiveLessonChunkComponentTextArea component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<LongAnswerTextArea> createState() => _LongAnswerTextAreaState();
}

class _LongAnswerTextAreaState extends State<LongAnswerTextArea> {
  String text = '';
  final List<bool> _isButtonDisabled = [];
  final List<String> successText = [];
  int numberOfTextField = 1;

  final List<TextEditingController> _controllers = [];
  final List<bool> _disabled = [];

  DateTime _dateTime = DateTime.timestamp();
  bool editPermission = false;
  final List<InteractiveLessonTextAreaHistory> componentHistory = [];

  @override
  void initState() {
    if (widget.component.progress == null) {
      _controllers.add(TextEditingController());
      _disabled.add(false);
      _isButtonDisabled.add(false);
      successText.add('');
      numberOfTextField = 1;
      return;
    }

    final history = widget.component.progress!.history!;
    componentHistory.addAll(history);

    for (var i = 0; i < history.length; i++) {
      _controllers.add(TextEditingController());
      _controllers[i].text = history[i].text;
      _disabled.add(true);
      _isButtonDisabled.add(false);
      successText.add('Saved');
      numberOfTextField = i + 1;
      if (history[i].text.isNotEmpty) {
        editPermission = true;
      }
    }

    super.initState();
  }

  void _onChangeHandler(String e, int i) {
    setState(() {
      text = e;
      _isButtonDisabled[i] = e.isNotEmpty;
    });
  }

  void _onSaveHandler(String textToSave, int i) {
    print(i);
    // _removeFocus(i);

    setState(() {
      successText[i] = 'Saved';
      _dateTime = DateTime.now();
      editPermission = true;
      _disabled[i] = true;
    });

    final answer = InteractiveLessonTextAreaHistory(
        text: textToSave, createdAt: _dateTime);
    componentHistory.add(answer);

    // заглушка, delete after add backend
    if (numberOfTextField == widget.component.minTextFieldsAmount) {
      widget.onSaveProgress(
          InteractiveLessonComponentProgress(history: componentHistory),
          widget.component);
    }

    _isButtonDisabled[i] = false;
  }

  void _editTextHandler(int i) {
    // _focusNode.unfocus();
    setState(() {
      _disabled[i] = false;
    });

    componentHistory.removeAt(i);
    widget.onSaveProgress(
        InteractiveLessonComponentProgress(history: componentHistory),
        widget.component);

    // _focusNode.requestFocus();
  }

  void _clearTextHandler(int i) {
    if (numberOfTextField > 1) {
      numberOfTextField--;

      _controllers.removeAt(i);
      _disabled.removeAt(i);
      successText.removeAt(i);

      print("_disabled: ${_disabled}");
      print("_controllers: ${_controllers.length}");
      print("_controllers: ${numberOfTextField}");

      //_components.removeAt(i);
      _changeHistory(i);
    } else {
      _controllers[i].clear();
      _changeHistory(i);
      setState(() {
        _disabled[i] = false;
        editPermission = false;
      });
    }
  }

  void _changeHistory(int i) {
    // if (text.isNotEmpty) {
    final historyToChange = componentHistory[i];
    final newHistory =
        componentHistory.where((c) => c.text != historyToChange.text).toList();

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(history: newHistory),
        widget.component);

    // }
    // componentHistory.removeAt(i);
  }

  void _addComponent() {
    setState(() {
      _controllers.add(TextEditingController());
      _disabled.add(false);
      numberOfTextField++;
      successText.add('');
      _isButtonDisabled.add(false);
      editPermission = false;

      print('numberOfTextField: $numberOfTextField');
      print("_controllers: ${_controllers.length}");

      // for(final controller in _controllers){
      // _components.add(
      //   LongAnswerTextAreaItem(

      //     text: controller.text,
      //     isButtonDisabled: isButtonDisabled,
      //     successText: successText,
      //     controller: controller,
      //     // focusNode: _focusNode,
      //     dateTime: _dateTime,
      //     lessonStreamType: widget.lessonStreamType,
      //     clearTextHandler: _clearTextHandler,
      //     editTextHandler: _editTextHandler,
      //     onSaveHandler: _onSaveHandler,
      //     onChangeHandler: _onChangeHandler,
      //     addComponent: _addComponent,
      //   ),
      // );
      // }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    // _focusNode.dispose();
    super.dispose();
  }

  TextFieldContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    print('----------------------------');
    print('numberOfTextField: $numberOfTextField');
    print("1: ${widget.component.maxCharsLength}");
    print("2: ${widget.component.minTextFieldsAmount}");
    print(widget.component.progress?.history?.length);
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
        ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(
            height: 10,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _controllers.length,
          itemBuilder: (context, i) => LongAnswerTextAreaItem(
            text: _controllers[i].text,
            readOnly: _disabled[i],
            // focusNode: _focusNodes[i],
            // history: widget.component.progress?.history?[i],
            isButtonDisabled: _isButtonDisabled[i],
            successText: successText[i],
            controller: _controllers[i],
            dateTime: _dateTime,
            lessonStreamType: widget.lessonStreamType,
            clearTextHandler: () => _clearTextHandler(i),
            editTextHandler: () => _editTextHandler(i),
            onSaveHandler: (text) => _onSaveHandler(text, i),
            onChangeHandler: (text) => _onChangeHandler(text, i),
            // addComponent: _addComponent,
            maxLength: widget.component.maxCharsLength,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        numberOfTextField == widget.component.maxTextFieldsAmount
            ? Container()
            : Column(
                children: [
                  Center(
                    child: CustomIconButton.custom(
                      onPressed: text.isEmpty || !editPermission
                          ? null
                          : _addComponent,
                      icon: AppIcons.interactiveLessonAddTextField(
                          editPermission,
                          widget.lessonStreamType.regularColor,
                          AppColors.greyLighter),
                    ),
                  ),
                  Center(
                    child: CustomText(
                      'Add textfield',
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
