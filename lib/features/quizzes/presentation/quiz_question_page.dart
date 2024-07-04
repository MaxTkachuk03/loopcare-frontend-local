import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/error_invoker.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/quizzes/application/quizzes_bloc.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz_question.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz_question_option.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/correct_incorrect_explanation.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/quiz_question_options_list.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class QuizQuestionPage extends StatefulWidget {
  final int step;
  final RiverModuleStreamType streamType;

  const QuizQuestionPage({super.key, required this.step, required this.streamType});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late QuestionsPageMode _mode;
  late QuizQuestion _currentQuestion;
  bool _isAnswerCorrect = false;
  bool _hasAnswer = false;

  int _totalSteps = 1;
  int _selectedAnswer = 0;

  @override
  void initState() {
    super.initState();

    final lessonStateData = context.read<EducationLessonBloc>().state.data;
    final quiz = lessonStateData.quiz;

    if (quiz == null) return;

    _totalSteps = lessonStateData.quizQuestionsAmount;

    _currentQuestion = quiz.questions.get(widget.step);

    _selectedAnswer =
        _currentQuestion.answers.isEmpty ? 0 : _currentQuestion.answers.first.optionId;

    final correctAnswer = _currentQuestion.options.firstWhere((o) => o.isCorrect ?? false);

    _isAnswerCorrect = correctAnswer.id == _selectedAnswer;

    _hasAnswer = _currentQuestion.answers.isNotEmpty;

    _mode = _selectedAnswer != 0
        ? const QuestionsPageMode.showAnswer()
        : const QuestionsPageMode.askQuestion();
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

  bool _nextStepListenWhen(QuizzesState previous, QuizzesState current) =>
      (ModalRoute.of(context)?.isCurrent ?? false) &&
      previous is QuizzesStateLoading &&
      current is QuizzesStateUpdated;

  void _onStepChangeListener(BuildContext context, QuizzesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  void _onSelectedHandler(QuizQuestionOption item) {
    setState(() {
      _mode = const QuestionsPageMode.showAnswer();
      _selectedAnswer = item.id;
    });
  }

  void _onNextHandler() {
    if (widget.step == (_totalSteps - 1)) {
      context.router.push(LessonCompleteRoute(streamType: widget.streamType));
    } else {
      context.router.push(QuizQuestionRoute(step: widget.step + 1, streamType: widget.streamType));
    }
  }

  void _saveOptionsField() {
    if (_hasAnswer) {
      _onNextHandler();
    } else {
      final educationBloc = context.read<EducationLessonBloc>();

      educationBloc.add(EducationLessonEvent.answerQuizQuestion(
        questionOptionId: _selectedAnswer,
        questionId: _currentQuestion.id,
      ));

      AnalyticsEventService.instance.logEvent(
        FirebaseEvents.userCompleteQuiz,
        parameters: {
          CustomDefinitions.lessonId: educationBloc.state.data.id,
          CustomDefinitions.title: _currentQuestion.question,
          CustomDefinitions.questionId: _currentQuestion.id.toString(),
          CustomDefinitions.value: _selectedAnswer.toString(),
        },
      );
    }
  }

  get _answerText => _isAnswerCorrect
      ? _currentQuestion.explanationCorrect ?? LocalizedTexts.correct.tr()
      : _currentQuestion.explanationIncorrect ?? LocalizedTexts.incorrect.tr();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: widget.streamType.lightestColor,
      appBar: CustomAppBar(
        backgroundColor: widget.streamType.regularColor,
        textTheme: widget.streamType.appBarTextTheme,
        title: LocalizedTexts.quiz.tr(),
        subtitle: _title,
        leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        actions: const [ErrorInvokeButton()],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: SimpleProgressBar(
            backgroundColor: widget.streamType.regularColor,
            progressFillColor: widget.streamType.lightestColor,
            progressEmptyColor: AppColors.white.withOpacity(0.45),
            progress: _percent,
          ),
        ),
      ),
      body: CustomSafeArea(
        child: ErrorInvoker(
          child: ScrollableContainer(
            child: BlocListener<QuizzesBloc, QuizzesState>(
              listenWhen: _nextStepListenWhen,
              listener: _onStepChangeListener,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 32),
                      MainContainer(
                        child: BlocBuilder<EducationLessonBloc, EducationLessonState>(
                          builder: (context, EducationLessonState state) {
                            return Form(
                              key: _formKey,
                              child: QuizQuestionOptionsList(
                                selectedValue: _selectedAnswer,
                                mode: _mode,
                                question: _currentQuestion,
                                onSelected: _onSelectedHandler,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      _mode.map(
                        askQuestion: (_) => const SizedBox.shrink(),
                        showAnswer: (_) => Container(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
                            child: Column(
                              children: [
                                CorrectIncorrectExplanation(
                                  isCorrect: _isAnswerCorrect,
                                  text: _answerText,
                                ),
                                const SizedBox(height: 24),
                                CustomElevatedButton.blueFullWidth(
                                  onPressed: _saveOptionsField,
                                  label: LocalizedTexts.next.tr(),
                                ),
                              ],
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
      ),
    );
  }
}
