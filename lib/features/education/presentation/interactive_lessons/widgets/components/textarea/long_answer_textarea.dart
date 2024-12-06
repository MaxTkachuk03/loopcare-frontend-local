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
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class LongAnswerTextArea extends StatefulWidget {
  const LongAnswerTextArea({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
    required this.isAllTextAreasAdded,
  });

  final InteractiveLessonChunkComponentTextArea component;
  final RiverModuleStreamType lessonStreamType;
  final Function(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component)
      onSaveProgress;
  final bool isAllTextAreasAdded;

  @override
  State<LongAnswerTextArea> createState() => _LongAnswerTextAreaState();
}

class _LongAnswerTextAreaState extends State<LongAnswerTextArea> {
  String text = '';
  int numberOfTextField = 1;
  bool editPermission = false;
  bool isEditing = false;
  bool canDelete = false;

  final List<bool> _isButtonDisabled = [];
  final List<String> successText = [];
  final List<TextEditingController> _controllers = [];
  final List<bool> _disabled = [];
  final List<DateTime> _dateTime = [];
  final List<FocusNode> _focusNodes = [];
  final List<InteractiveLessonTextAreaHistory> componentHistory = [];

  @override
  void initState() {
    if (widget.component.progress == null) {
      initTextArea();
      return;
    }

    final history = widget.component.progress!.history!;

    componentHistory.addAll(history);
    setDeleteButtonStatus();

    for (int i = 0; i < history.length; i++) {
      _controllers.add(TextEditingController(text: history[i].text));
      _isButtonDisabled.add(false);
      successText.add('Saved');
      _dateTime.add(DateTime.timestamp());
      _focusNodes.add(FocusNode());
      numberOfTextField = i + 1;
      _disabled.add(true);
      editPermission = true;
    }
    super.initState();
  }

  void initTextArea() {
    _controllers.add(TextEditingController());
    _disabled.add(false);
    _isButtonDisabled.add(false);
    successText.add('');
    numberOfTextField = 1;
    _focusNodes.add(FocusNode());
    _dateTime.add(DateTime.timestamp());
  }

  void setDeleteButtonStatus() {
    if (componentHistory.length > widget.component.minTextFieldsAmount) {
      setState(() {
        canDelete = true;
      });
    } else {
      setState(() {
        canDelete = false;
      });
    }
  }

  void _onChangeHandler(String e, int i) {
    setState(() {
      text = e;
      _isButtonDisabled[i] = e.isNotEmpty;
    });
  }

  void _onSaveHandler(String textToSave, int i) {
    setState(() {
      successText[i] = 'Saved';
      _dateTime[i] = DateTime.now();
      editPermission = true;
      _disabled[i] = true;
    });

    if (isEditing) {
      componentHistory[i] = InteractiveLessonTextAreaHistory(
          text: textToSave, updatedAt: _dateTime[i], createdAt: componentHistory[i].createdAt);
      setState(() {
        isEditing = false;
      });
    } else {
      final answer = InteractiveLessonTextAreaHistory(text: textToSave, createdAt: _dateTime[i]);
      componentHistory.add(answer);
      setDeleteButtonStatus();
    }

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(history: componentHistory, type: widget.component.type.name), widget.component);

    setState(() {
      _isButtonDisabled[i] = false;
    });
  }

  void _editTextHandler(int i) {
    setState(() {
      _disabled[i] = false;
      isEditing = true;
    });

    _focusNodes[i].requestFocus();
  }

  void _clearTextHandler(int i) {
    setState(() {
      numberOfTextField--;
      _controllers.removeAt(i);
      _disabled.removeAt(i);
      successText.removeAt(i);
      _focusNodes.removeAt(i);
      _isButtonDisabled.removeAt(i);
      _dateTime.removeAt(i);
      componentHistory.removeAt(i);
    });

    setDeleteButtonStatus();

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(history: componentHistory, type: widget.component.type.name), widget.component);
  }

  void _addComponent() {
    setState(() {
      _controllers.add(TextEditingController());
      _disabled.add(false);
      numberOfTextField++;
      successText.add('');
      _isButtonDisabled.add(false);
      editPermission = false;
      _dateTime.add(DateTime.timestamp());
      _focusNodes.add(FocusNode());
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focus in _focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }

  TextFieldContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsTextAreaLabel.tr(),
          lessonStreamType: widget.lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(
          content.question,
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            CustomText(
              content.subtext!,
              style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
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
            key: ValueKey(i),
            text: _controllers[i].text,
            readOnly: _disabled[i],
            focusNode: _focusNodes[i],
            isButtonDisabled: _isButtonDisabled[i],
            successText: successText[i],
            controller: _controllers[i],
            dateTime: _dateTime[i],
            lessonStreamType: widget.lessonStreamType,
            clearTextHandler: () => _clearTextHandler(i),
            editTextHandler: () => _editTextHandler(i),
            onSaveHandler: (text) => _onSaveHandler(text, i),
            onChangeHandler: (text) => _onChangeHandler(text, i),
            maxLength: widget.component.maxCharsLength,
            canDelete: canDelete,
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
                      onPressed: !editPermission ? null : _addComponent,
                      icon: AppIcons.interactiveLessonAddTextField(editPermission,
                          widget.lessonStreamType.lighterColor, AppColors.greyLighter),
                    ),
                  ),
                  Center(
                    child: CustomText(
                      'Add textfield',
                      style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
