import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/error_invoker.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question_option.dart';
import 'package:loopcare_frontend/features/lesson_quiz/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/lesson_quiz/presentation/widgets/answer_explanation.dart';
import 'package:loopcare_frontend/features/lesson_quiz/presentation/widgets/quiz_question_options_list.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class QuizQuestionPage extends StatefulWidget {
  final int step;
  final RiverModuleStreamType streamType;

  const QuizQuestionPage({super.key, required this.step, required this.streamType});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
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

    _currentQuestion = quiz.questions.elementAt(widget.step);

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
      LocalizedTexts.stepCounter.tr({'currentStep': widget.step + 1, 'totalSteps': _totalSteps});

  int get _percent => ((widget.step + 1) * 100 / _totalSteps).round();

  void _onSelectedHandler(QuizQuestionOption item) {
    setState(() {
      _mode = const QuestionsPageMode.showAnswer();
      _selectedAnswer = item.id;
      _isAnswerCorrect = item.isCorrect ?? false;
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
    if (!_hasAnswer) {
      final educationBloc = context.read<EducationLessonBloc>();

      educationBloc.add(EducationLessonEvent.answerQuizQuestion(
        questionOptionId: _selectedAnswer,
        questionId: _currentQuestion.id,
      ));

      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.userCompleteQuiz,
        parameters: {
          AnalyticsParameters.lessonId: educationBloc.state.data.id,
          AnalyticsParameters.title: _currentQuestion.question,
          AnalyticsParameters.questionId: _currentQuestion.id.toString(),
          AnalyticsParameters.value: _selectedAnswer.toString(),
        },
      );
    }

    _onNextHandler();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, EducationLessonState state) {
                          return QuizQuestionOptionsList(
                            selectedValue: _selectedAnswer,
                            mode: _mode,
                            question: _currentQuestion,
                            onSelected: _onSelectedHandler,
                          );
                        },
                      )
                    ],
                  ),
                ),
                _mode.map(
                  askQuestion: (_) => const SizedBox.shrink(),
                  showAnswer: (_) => Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                      child: Column(
                        children: [
                          AnswerExplanation(isCorrect: _isAnswerCorrect, text: _answerText),
                          const SizedBox(height: 24),
                          CustomElevatedButton.blueFullWidth(
                            onPressed: _saveOptionsField,
                            label: LocalizedTexts.next.tr(),
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
      ),
    );
  }
}
