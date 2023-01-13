import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_clickable_text.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_fitness_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/widgets/weight_tabs.dart';

class WeightPage extends StatelessWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocalizedTexts.yourWeight.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 48,
          ),
          const WeightTabs(),
          const SizedBox(
            height: 16.0,
          ),
          UnderlinedClickableText(
            text: LocalizedTexts.needHelpWithThis.tr(),
            onTap: _onHelpTap,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const _NextButton(),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  void _onHelpTap() {}
}

class _NextButton extends StatelessWidget {
  const _NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final physicalFitnessNavigationState =
        PhysicalFitnessNavigationState.of(context);

    return ElevatedButton(
      onPressed: physicalFitnessNavigationState.onNextPage,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
          ),
      child: Text(LocalizedTexts.next.tr()),
    );
  }
}
