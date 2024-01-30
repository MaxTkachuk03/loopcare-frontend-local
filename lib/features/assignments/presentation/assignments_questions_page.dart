import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/infrastructure/answer_widget_type.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_option.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_scale.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_text.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_answer_type.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AssignmentsQuestionsPage extends StatefulWidget {
  final int step;
  final bool fromDashboard;

  const AssignmentsQuestionsPage({super.key, required this.step, required this.fromDashboard});

  @override
  State<AssignmentsQuestionsPage> createState() => _AssignmentsQuestionsPageState();
}

class _AssignmentsQuestionsPageState extends State<AssignmentsQuestionsPage> {
  late QuizzesController _controller;
  QuestionsPageMode mode = const QuestionsPageMode.askQuestion();
  late AnswerWidgetType widgetType;
  int _totalSteps = 1;
  late LessonQuestion question;
  bool isNotSaved = true;
  late int lessonId;

  @override
  void initState() {
    final questionsState = context.read<AssignmentsBloc>().state;
    lessonId = questionsState.data.lessonId;

    _totalSteps = questionsState.data.questionsForLesson(lessonId).isNotEmpty
        ? questionsState.data.questionsForLesson(lessonId).length
        : 1;

    _controller = mode.map(
      askQuestion: (_) => QuizzesController()..addFocusNodeListeners(),
      showAnswer: (s) => QuizzesController()..addFocusNodeListeners(),
    );

    setStep(widget.step);
    super.initState();
  }

  String get _title =>
      LocalizedTexts.stepCounter.tr(args: [(widget.step + 1).toString(), _totalSteps.toString()]);

  void _onSelectOptionHandler(int id) {
    setState(() {
      _controller.selectOptionValue(
        id,
        multiSelect: widgetType == const AnswerWidgetType.multipleChoiceMultiple(),
      );
    });
  }

  void _onNextHandler({bool isEditable = true}) {
    if (widget.step == (_totalSteps - 1)) {
      if (isEditable) {
        final authState = context.read<AuthenticationCubit>().state;
        var emailApproveDate = authState.emailApproveDate ?? DateTime.now();

        context.read<AssignmentsBloc>().add(
              AssignmentsEvent.getAllLessonQuestions(
                emailApproveDate,
                DateTime.now(),
              ),
            );
        if (widget.fromDashboard) {
          context.router.pushNamed(AppRoutes.assignmentsSaved);
        } else {
          context.router.pushNamed(AppRoutes.lessonComplete);
        }
      } else {
        context.router.popUntilRouteWithName(MyAssignmentsRoute.name);
      }
    } else {
      context.router.push(
        AssignmentsQuestionsRoute(
          step: widget.step + 1,
          fromDashboard: widget.fromDashboard,
        ),
      );
    }
  }

  void _onPrevHandler() {
    context.router.pop();
  }

  void _saveTextField(int lessonId) {
    if (!question.isEditable) {
      _onNextHandler();
      return;
    }

    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();

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
  }

  void _saveOptionsField(int lessonId) {
    if (!question.isEditable) {
      _onNextHandler();
      return;
    }

    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();

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
  }

  void _saveScaleField(int lessonId) {
    if (!question.isEditable) {
      _onNextHandler();
      return;
    }

    _controller.isEnableSend.value = false;

    var questionsBloc = context.read<AssignmentsBloc>();

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
  }

  void _onErrorHandler(AssignmentsState state) {
    final String? errorMessage = state.data.error?.maybeMap(
      unprocessableEntity: (s) => s.error.message,
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
    );

    context.showError(content: Text(errorMessage ?? ''));
  }

  void _onUpdateHandler(AssignmentsState state) {
    isNotSaved = false;
    _onNextHandler();
  }

  bool _nextStepListenWhen(AssignmentsState previous, AssignmentsState current) {
    return previous is AssignmentsStateLoading && current is AssignmentsStateUpdated && isNotSaved;
  }

  void _onStepChangeListener(BuildContext context, AssignmentsState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  void _onSelectScaleHandler(int value) {
    setState(() {
      _controller.setScaleValue(value);
    });
  }

  String? _feedbackText(int? value, LessonQuestion question) {
    if (value == null) return null;
    int label = int.tryParse(question.lessonQuestionOptionsLabels[value]) ?? int.parse('${value + 1}');
    return question.lessonQuestionFeedback(question.id, label)?.text;
  }

  void setStep(int currStep) {
    setState(() {
      var questionsBloc = context.read<AssignmentsBloc>();
      question = questionsBloc.state.data.questionForStep(lessonId, widget.step);

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
          child: CustomText('multipleChoiceValidation'),
        ),
        scale: (_) => AnswerScale(
          isEditable: question.isEditable,
          controller: _controller,
          question: question,
          onNextPressed: () => question.isEditable
              ? _controller.isScaleChoiceValid
                  ? _saveScaleField(state.data.lessonId)
                  : null
              : _onNextHandler(isEditable: false),
          onSelectValue: _onSelectScaleHandler,
          selectedScore: _controller.selectScaleValue.value,
          feedbackText: _feedbackText(_controller.selectScaleValue.value, question),
        ),
        multipleChoiceMultiple: (_) => AnswerOption(
          isEditable: question.isEditable,
          controller: _controller,
          question: question,
          onNextPressed: () => question.isEditable
              ? _controller.isOptionChoiceValid
                  ? _saveOptionsField(state.data.lessonId)
                  : null
              : _onNextHandler(isEditable: false),
          onSelectOptionValue: _onSelectOptionHandler,
        ),
        multipleChoiceSingle: (_) => AnswerOption(
          isEditable: question.isEditable,
          controller: _controller,
          question: question,
          onNextPressed: () => question.isEditable
              ? _controller.isOptionChoiceValid
                  ? _saveOptionsField(state.data.lessonId)
                  : null
              : _onNextHandler(isEditable: false),
          onSelectOptionValue: _onSelectOptionHandler,
        ),
        text: (_) => AnswerText(
          isEditable: question.isEditable,
          mode: question.isEditable ? mode : const QuestionsPageMode.showAnswer(),
          controller: _controller,
          question: question,
          onNextPressed: (int lessonId) => question.isEditable
              ? _controller.isOpenTextValid
                  ? _saveTextField(state.data.lessonId)
                  : null
              : _onNextHandler(isEditable: false),
          onAnswerPressed: () => setState(
            () {
              mode = const QuestionsPageMode.askQuestion();
            },
          ),
        ),
      );

  int get _percent => ((widget.step + 1) * 100 / _totalSteps).round();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.assignment.tr(),
        subtitle: _title,
        leading: CustomFilledIconButton.leadingPetrolLighter(onPressed: _onPrevHandler),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: SimpleProgressBar.petrol(progress: _percent),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: BlocListener<AssignmentsBloc, AssignmentsState>(
              listenWhen: _nextStepListenWhen,
              listener: _onStepChangeListener,
              child: BlocBuilder<AssignmentsBloc, AssignmentsState>(
                builder: (context, state) {
                  return state.maybeMap(
                    loading: (_) => const Loader(),
                    orElse: () => content(state),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
