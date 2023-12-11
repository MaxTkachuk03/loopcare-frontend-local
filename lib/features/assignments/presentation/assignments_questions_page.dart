import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/infrastructure/answer_widget_type.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_option.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_scale.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_text.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_answer_type.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AssignmentsQuestionsPage extends StatefulWidget {
  final int step;
  const AssignmentsQuestionsPage({
    super.key,
    required this.step,
  });

  @override
  State<AssignmentsQuestionsPage> createState() => _AssignmentsQuestionsPageState();
}

class _AssignmentsQuestionsPageState extends State<AssignmentsQuestionsPage> {
  late QuizzesController _controller;
  QuestionsPageMode mode = const QuestionsPageMode.askQuestion();
  late AnswerWidgetType widgetType;
  int _totalSteps = 1;

  @override
  void initState() {
    final questionsState = context.read<AssignmentsBloc>().state;
    _totalSteps = questionsState.data.questions.isNotEmpty ? questionsState.data.questions.length : 1;

    _controller = mode.map(
      askQuestion: (_) => QuizzesController()..addFocusNodeListeners(),
      showAnswer: (s) => QuizzesController()..addFocusNodeListeners(),
    );

    setStep(widget.step);
    super.initState();
  }

  String get _title => LocalizedTexts.questionOf.tr(
        namedArgs: {
          'step': (widget.step + 1).toString(),
          'total': _totalSteps.toString(),
        },
      );

  int get _percent => ((widget.step + 1) * 100 / _totalSteps).round();

  void _onSelectOptionHandler(int id) {
    setState(() {
      _controller.selectOptionValue(
        id,
        multiSelect: widgetType == const AnswerWidgetType.multipleChoiceMultiple(),
      );
    });
  }

  get _mainContainerBgColor {
    return mode.map(
      askQuestion: (_) => AppColors.bgGreen,
      showAnswer: (_) => AppColors.bgGreen,
    );
  }

  void _onNextHandler() {
    if (widget.step == (_totalSteps - 1)) {
      context.router.pushNamed(AppRoutes.lessonComplete);
    } else {
      context.router.push(AssignmentsQuestionsRoute(step: widget.step + 1));
    }
  }

  void _onPrevHandler() {
    context.router.pop();
  }

  void _saveTextField(int lessonId) {
    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();
    var question = questionsBloc.state.data.questionForStep(widget.step);

    if (question.questionAnswer != null) {
      questionsBloc.add(
        AssignmentsEvent.updateLessonAnswerText(
          question.id,
          text: _controller.answerTextController.value.text,
        ),
      );
    } else {
      questionsBloc.add(
        AssignmentsEvent.saveLessonAnswerText(
          question.id,
          text: _controller.answerTextController.value.text,
        ),
      );
    }

    _onNextHandler();
  }

  void _saveOptionsField(int lessonId) {
    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();
    var question = questionsBloc.state.data.questionForStep(widget.step);
    if (question.questionAnswer != null) {
      questionsBloc.add(
        AssignmentsEvent.updateLessonAnswerOption(
          question.id,
          lessonQuestionOptionIds: _controller.selectOptionValues.value,
        ),
      );
    } else {
      questionsBloc.add(
        AssignmentsEvent.saveLessonAnswerOption(
          question.id,
          lessonQuestionOptionIds: _controller.selectOptionValues.value,
        ),
      );
    }

    _onNextHandler();
  }

  void _saveScaleField(int lessonId) {
    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();
    var question = questionsBloc.state.data.questionForStep(widget.step);

    var selectScaleIndex = _controller.selectScaleValue.value;

    if (selectScaleIndex != null) {
      var lessonQuestionOptionId = question.lessonQuestionOptions.elementAt(selectScaleIndex).id;

      if (question.questionAnswer != null) {
        questionsBloc.add(
          AssignmentsEvent.updateLessonAnswerOption(
            question.id,
            lessonQuestionOptionIds: [lessonQuestionOptionId],
          ),
        );
      } else {
        questionsBloc.add(
          AssignmentsEvent.saveLessonAnswerOption(
            question.id,
            lessonQuestionOptionIds: [lessonQuestionOptionId],
          ),
        );
      }
    }

    _onNextHandler();
  }

  void _onSelectScaleHandler(int value) {
    setState(() {
      _controller.setScaleValue(value);
    });
  }

  void setStep(int currStep) {
    setState(() {
      var questionsBloc = context.read<AssignmentsBloc>();
      var question = questionsBloc.state.data.questionForStep(widget.step);

      mode = question.questionAnswer != null
          ? const QuestionsPageMode.showAnswer()
          : const QuestionsPageMode.askQuestion();

      if (question.questionAnswer != null) {
        if (question.answerType == LessonQuestionAnswerType.text) {
          _controller.answerTextController.text = question.questionAnswer?.text ?? '';
        } else if (question.answerType == LessonQuestionAnswerType.multipleChoiceMultiple ||
            question.answerType == LessonQuestionAnswerType.multipleChoiceSingle) {
          _controller.setOptionValue(question.lessonQuestionAnswersId);
        } else if (question.answerType == LessonQuestionAnswerType.scale) {
          _controller
              .setScaleValue(question.lessonQuestionOptionIndexById(question.lessonQuestionAnswersId.first));
        }
      }

      widgetType = question.answerType.widgetType;
    });
  }

  Widget content(AssignmentsState state) => widgetType.map(
        multipleChoiceValidation: (_) => const SizedBox(
          child: Text('multipleChoiceValidation'),
        ),
        scale: (_) => AnswerScale(
          controller: _controller,
          question: state.data.questionForStep(widget.step),
          onNextPressed: () => _saveScaleField(state.data.lessonId),
          onSelectValue: _onSelectScaleHandler,
          selectedScore: _controller.selectScaleValue.value,
        ),
        multipleChoiceMultiple: (_) => AnswerOption(
          controller: _controller,
          question: state.data.questionForStep(widget.step),
          onNextPressed: () => _saveOptionsField(state.data.lessonId),
          onSelectOptionValue: _onSelectOptionHandler,
        ),
        multipleChoiceSingle: (_) => AnswerOption(
          controller: _controller,
          question: state.data.questionForStep(widget.step),
          onNextPressed: () => _saveOptionsField(state.data.lessonId),
          onSelectOptionValue: _onSelectOptionHandler,
        ),
        text: (_) => AnswerText(
          mode: mode,
          controller: _controller,
          question: state.data.questionForStep(widget.step),
          onNextPressed: () => _controller.isOpenTextValid ? _saveTextField(state.data.lessonId) : null,
          onAnswerPressed: () => setState(
            () {
              mode = const QuestionsPageMode.askQuestion();
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bgGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _onPrevHandler,
            ),
            Column(
              children: [
                Text(
                  LocalizedTexts.assignment.translation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  _title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                ProgressBar(
                  progress: _percent,
                  backgroundColor: AppColors.bgGreen,
                ),
              ],
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      body: Container(
        color: _mainContainerBgColor,
        child: SafeArea(
          child: ScrollableContainer(
            child: BlocBuilder<AssignmentsBloc, AssignmentsState>(
              builder: (context, state) {
                return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () => Container(
                    color: AppColors.bgGreen,
                    child: content(state),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
