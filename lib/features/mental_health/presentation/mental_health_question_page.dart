import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/mental_health_question_form.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/question_text.dart';

class MentalHealthQuestionPage extends StatefulWidget {
  const MentalHealthQuestionPage({Key? key}) : super(key: key);

  @override
  State<MentalHealthQuestionPage> createState() => _MentalHealthQuestionPageState();
}

class _MentalHealthQuestionPageState extends State<MentalHealthQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: MentalHealthWrap(
          child: BlocBuilder<MentalHealthBloc, MentalHealthState>(
            builder: (context, state) {
              final currentQuestion = state.data.currentQuestion;
              if (currentQuestion == null) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const QuestionText(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    currentQuestion.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Expanded(child: MentalHealthQuestionForm())
                ],
              );
            },
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    final bloc = context.read<MentalHealthBloc>();

    if (bloc.state.data.isFirstQuestion && !bloc.state.data.isFirstTest) {
      bloc.add(const MentalHealthEvent.prevTest());
    } else {
      bloc.add(const MentalHealthEvent.prevQuestion());
    }

    return Future.value(true);
  }
}
