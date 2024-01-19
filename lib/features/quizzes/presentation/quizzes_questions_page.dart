import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
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

  String get _title =>
      LocalizedTexts.stepCounter.tr(args: [(widget.step + 1).toString(), _totalSteps.toString()]);

  int get _percent => ((widget.step + 1) * 100 / _totalSteps).round();

  _onErrorHandler(QuizzesState s) {
    context.showError(content: Text(s.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr()));
  }

  void _onUpdateHandler(QuizzesState state) {
    _onNextHandler();
  }

  bool _nextStepListenWhen(QuizzesState previous, QuizzesState current) {
    return previous is QuizzesStateLoading && current is QuizzesStateUpdated;
  }

  void _onStepChangeListener(BuildContext context, QuizzesState state) {
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
    } else {
      _onNextHandler();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.quiz.tr(),
        subtitle: _title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: BlocListener<QuizzesBloc, QuizzesState>(
            listenWhen: _nextStepListenWhen,
            listener: _onStepChangeListener,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SimpleProgressBar.petrol(progress: _percent),
                    const SizedBox(height: 32),
                    MainContainer(
                      child: BlocBuilder<QuizzesBloc, QuizzesState>(
                        builder: (context, state) {
                          return state.maybeMap(
                            loading: (_) => const Loader(),
                            orElse: () => Form(
                              key: _controller.formKey,
                              onChanged: () => _controller.isFormValid,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  QuizzesQuestion(
                                    selectedValue: _controller.selectLessonValue.value,
                                    mode: mode,
                                    question: state.data.questionForStep(widget.step),
                                    onSelected: _onSelectedHandler,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    mode.map(
                      askQuestion: (_) => const SizedBox.shrink(),
                      showAnswer: (_) => Container(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
                          child: BlocBuilder<QuizzesBloc, QuizzesState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  ValueListenableBuilder<bool>(
                                      valueListenable: _controller.isCorrect,
                                      builder: (context, isCorrect, _) {
                                        return CorrectIncorrectExplanation(
                                          isCorrect: _controller.isFormValid,
                                          text: _controller.isFormValid
                                              ? state.data.questionForStep(widget.step).explanationCorrect ??
                                                  LocalizedTexts.correct.tr()
                                              : state.data
                                                      .questionForStep(widget.step)
                                                      .explanationIncorrect ??
                                                  LocalizedTexts.incorrect.tr(),
                                        );
                                      }),
                                  const SizedBox(height: 24),
                                  CustomElevatedButton.blueFullWidth(
                                    onPressed: () => _saveOptionsField(state.data.lessonId),
                                    label: LocalizedTexts.next,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
