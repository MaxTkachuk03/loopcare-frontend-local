import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
      builder: (context, state) {
        return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              if (state.data.noGoalsSelected) return const _EmptyGoalsList();

              return Text('filler');
            });
      },
    );
  }
}

class _EmptyGoalsList extends StatelessWidget {
  const _EmptyGoalsList();

  void _onChooseGoalsHanler() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: CustomText.w400(
            LocalizedTexts.noGoalsSelected.tr(),
            style: context.textTheme.bodySmall,
          ),
        ),
        CustomElevatedButton.greenSmall(
          label: LocalizedTexts.chooseGoalsForUpcomingDays.tr(),
          onPressed: _onChooseGoalsHanler,
        ),
      ],
    );
  }
}
