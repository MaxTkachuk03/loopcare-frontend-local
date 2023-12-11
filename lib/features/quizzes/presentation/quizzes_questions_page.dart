import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/quizzes/application/quizzes_bloc.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_option.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/correct_incorrect_explanation.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/quizzes_question.dart';

class QuizzesQuestionsPage extends StatefulWidget {
  final int step;
  const QuizzesQuestionsPage({
    super.key,
    required this.step,
  });

  @override
  State<QuizzesQuestionsPage> createState() => _QuizzesQuestionsPageState();
}

class _QuizzesQuestionsPageState extends State<QuizzesQuestionsPage> {
  late QuizzesController _controller;
  QuestionsPageMode mode = const QuestionsPageMode.askQuestion();
  int _totalSteps = 1;
  int selectedValue = 0;

  @override
  void initState() {
    final quizzesState = context.read<QuizzesBloc>().state;
    _totalSteps = quizzesState.data.quizzes.isNotEmpty ? quizzesState.data.quizzes.length : 1;

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

  _onErrorHandler(QuizzesState s) {
    context.showError(content: Text(s.data.errorMessage ?? LocalizedTexts.somethingWentWrong.translation));
  }

  _onUpdateHandler(QuizzesState s) {
    // context.router.pop();
  }

  void _onChangeListener(BuildContext context, QuizzesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  void _onSelectedHandler(LessonQuestionOption item) {
    setState(() {
      mode = const QuestionsPageMode.showAnswer();
      selectedValue = item.id;
    });

    _controller.setLessonValue(item);
    _controller.isFormValid;
  }

  void _onPrevHandler() {
    context.router.pop();
  }

  void setStep(int currStep) {
    setState(() {
      var quizzesBloc = context.read<QuizzesBloc>();

      var question = quizzesBloc.state.data.questionForStep(currStep);

      mode = question.questionAnswer != null
          ? const QuestionsPageMode.showAnswer()
          : const QuestionsPageMode.askQuestion();

      if (question.questionAnswer != null) {
        _controller.setLessonValue(question.lessonQuestionOptionById(question.lessonQuestionAnswersId.first));
      }
    });
  }

  void _onNextHandler() {
    if (widget.step == (_totalSteps - 1)) {
      context.router.pushNamed(AppRoutes.lessonComplete);
    } else {
      context.router.push(QuizzesQuestionsRoute(step: widget.step + 1));
    }
  }

  void _saveOptionsField(int lessonId) {
    _controller.isEnableSend.value = false;
    var quizzesBloc = context.read<QuizzesBloc>();

    var question = quizzesBloc.state.data.questionForStep(widget.step);
    var selectLessonValueId = _controller.selectLessonValue.value?.id;

    if (question.questionAnswer == null) {
      quizzesBloc.add(
        QuizzesEvent.saveLessonAnswer(
          question.id,
          lessonQuestionOptionIds: selectLessonValueId != null ? [selectLessonValueId] : [],
        ),
      );
    }

    _onNextHandler();
  }

  get _mainContainerBgColor {
    return mode.map(
      askQuestion: (_) => AppColors.bgGreen,
      showAnswer: (_) => AppColors.white,
    );
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _onPrevHandler,
            ),
            Column(
              children: [
                Text(
                  LocalizedTexts.quiz.translation,
                  style: Theme.of(context).textTheme.bodySmall,
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
            child: BlocListener<QuizzesBloc, QuizzesState>(
              listener: _onChangeListener,
              child: BlocBuilder<QuizzesBloc, QuizzesState>(
                builder: (context, state) {
                  return state.maybeMap(
                    loading: (_) => const Loader(),
                    orElse: () => Form(
                      key: _controller.formKey,
                      onChanged: () => _controller.isFormValid,
                      child: Container(
                        color: AppColors.bgGreen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
                              child: QuizzesQuestion(
                                selectedValue: _controller.selectLessonValue.value,
                                mode: mode,
                                question: state.data.questionForStep(widget.step),
                                onSelected: (LessonQuestionOption value) {
                                  _onSelectedHandler(value);
                                },
                              ),
                            ),
                            mode.map(
                              askQuestion: (_) => const SizedBox.shrink(),
                              showAnswer: (_) => Container(
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
                                  child: Column(
                                    children: [
                                      ValueListenableBuilder<bool>(
                                          valueListenable: _controller.isCorrect,
                                          builder: (context, isCorrect, _) {
                                            return CorrectIncorrectExplanation(
                                              isCorrect: _controller.isFormValid,
                                              text: _controller.isFormValid
                                                  ? state.data
                                                          .questionForStep(widget.step)
                                                          .explanationCorrect ??
                                                      LocalizedTexts.correct.translation
                                                  : state.data
                                                          .questionForStep(widget.step)
                                                          .explanationIncorrect ??
                                                      LocalizedTexts.incorrect.translation,
                                            );
                                          }),
                                      const SizedBox(height: 32),
                                      ElevatedButton(
                                        onPressed: () => _saveOptionsField(state.data.lessonId),
                                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                              backgroundColor:
                                                  MaterialStateProperty.all(AppColors.orangeDark),
                                            ),
                                        child: const Text(LocalizedTexts.next).tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
