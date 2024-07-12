import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/question_answer_type.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/submit_reflection_body.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/multi_choice_question.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/scale_question.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/text_question.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class ReflectionQuestionPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final int step;
  final bool fromDashboard;

  const ReflectionQuestionPage({
    super.key,
    required this.step,
    required this.fromDashboard,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  State<ReflectionQuestionPage> createState() => _ReflectionQuestionPageState();
}

class _ReflectionQuestionPageState extends State<ReflectionQuestionPage> {
  late ReflectionQuestion _currentQuestion;
  int _totalSteps = 1;

  @override
  void initState() {
    super.initState();

    final reflection = context.read<ReflectionsBloc>().state.data.activeReflection;

    if (reflection == null) return;

    _currentQuestion = reflection.questions[widget.step];

    _totalSteps = reflection.questions.length;
  }

  void _answerScaleQuestion(String value) {
    final activeReflection = context.read<ReflectionsBloc>().state.data.activeReflection;

    if (activeReflection != null) {
      AnalyticsEventService.instance.assignmentMotivationScale(
          _currentQuestion.id.toString(), activeReflection, widget.fromDashboard);
    }

    final data = SubmitReflectionBody(
      reflectionQuestionId: _currentQuestion.id,
      reflectionQuestionOptionIds: [int.parse(value)],
    );

    _sendEvent(data);
  }

  void _answerMultipleChoiceQuestion(List<int> values) {
    final data = SubmitReflectionBody(
        reflectionQuestionId: _currentQuestion.id, reflectionQuestionOptionIds: values);

    _sendEvent(data);
  }

  void _answerTextQuestion(String value) {
    final data = SubmitReflectionBody(reflectionQuestionId: _currentQuestion.id, text: value);

    _sendEvent(data);
  }

  void _sendEvent(SubmitReflectionBody data) {
    final event = _currentQuestion.hasAnswer
        ? ReflectionsEvent.updateReflectionAnswer
        : ReflectionsEvent.saveReflectionAnswer;

    context.read<ReflectionsBloc>().add(event(data: data));
  }

  void _onErrorHandler(ReflectionsState s) =>
      context.showError(content: CustomText(s.data.error?.message ?? ''));

  void _onUpdateHandler(ReflectionsState s) {
    if (widget.step == (_totalSteps - 1)) {
      final activeReflection = context.read<ReflectionsBloc>().state.data.activeReflection;

      if (activeReflection != null) {
        AnalyticsEventService.instance.finalizeAssignment(
            FirebaseEvents.userCompleteAssignment, activeReflection, widget.fromDashboard);
      }

      context.router.push(ReflectionCompleteRoute(streamType: widget.streamType));
    } else {
      context.router.push(
        ReflectionQuestionRoute(
          step: widget.step + 1,
          fromDashboard: widget.fromDashboard,
          streamType: widget.streamType,
        ),
      );
    }
  }

  void _onReflectionUpdateListener(BuildContext context, ReflectionsState s) =>
      s.mapOrNull(error: _onErrorHandler, reflectionsLoaded: _onUpdateHandler);

  String get _title =>
      LocalizedTexts.stepCounter.tr(args: [(widget.step + 1).toString(), _totalSteps.toString()]);

  int get _percent => ((widget.step + 1) * 100 / _totalSteps).round();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReflectionsBloc, ReflectionsState>(
      listenWhen: (prev, cur) => context.isCurrentRouteActive,
      listener: _onReflectionUpdateListener,
      child: CustomScaffold(
        color: widget.streamType.lightestColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: widget.streamType.appBarTextTheme,
          title: LocalizedTexts.reflection.tr(),
          subtitle: _title,
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: SimpleProgressBar.petrol(progress: _percent),
          ),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: switch (_currentQuestion.answerType) {
                QuestionAnswerType.multipleChoiceValidation =>
                  const SizedBox(child: CustomText('multipleChoiceValidation')),
                QuestionAnswerType.scale =>
                  ScaleQuestion(question: _currentQuestion, onNextPressed: _answerScaleQuestion),
                QuestionAnswerType.multipleChoiceMultiple ||
                QuestionAnswerType.multipleChoiceSingle =>
                  MultiChoiceQuestion(
                      question: _currentQuestion, onNextPressed: _answerMultipleChoiceQuestion),
                QuestionAnswerType.text =>
                  TextQuestion(question: _currentQuestion, onNextPressed: _answerTextQuestion),
              },
            ),
          ),
        ),
      ),
    );
  }
}
