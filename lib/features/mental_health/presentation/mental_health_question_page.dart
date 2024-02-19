import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/mental_health_question_form.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/question_text.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class MentalHealthQuestionPage extends StatelessWidget {
  const MentalHealthQuestionPage({super.key});

  String _getSubtitle(BuildContext context) {
    final state = context.read<MentalHealthBloc>().state;

    final curQuestionId = state.data.currentQuestion?.id;

    if (curQuestionId == null) return '';

    final curIndex = state.data.questionsListId.indexOf(curQuestionId) + 1;

    return LocalizedTexts.stepCounter.tr(args: [
      curIndex.toString(),
      state.data.totalQuestionsLength.toString(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: MentalHealthWrap(
          child: CustomScaffold.orangeLightest(
            appBar: CustomAppBar.orange(
              title: LocalizedTexts.mentalHealth.tr(),
              subtitle: _getSubtitle(context),
              leading: CustomFilledIconButton.leadingOrangeLighter(),
            ),
            body: BlocBuilder<MentalHealthBloc, MentalHealthState>(
              builder: (context, state) {
                final currentQuestion = state.data.currentQuestion;
                if (currentQuestion == null) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressBar.blue(backgroundColor: AppColors.orangeRegular),
                    const SizedBox(height: 48.0),
                    const MainContainer(child: QuestionText()),
                    const SizedBox(height: 28.0),
                    MainContainer(
                      child: CustomText.bitter600(
                        currentQuestion.title,
                        style: context.textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 28.0),
                    const Expanded(
                      child: MainContainer(
                        child: MentalHealthQuestionForm(),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    final bloc = context.read<MentalHealthBloc>();

    if (bloc.state.data.isFirstQuestion && !bloc.state.data.isFirstTest) {
      bloc.add(const MentalHealthEvent.prevTest());
    } else {
      bloc.add(const MentalHealthEvent.prevQuestion());
    }

    return Future.value(true);
  }
}
