import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_clickable_text.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/widgets/height_tabs.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_fitness_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';

class HeightPage extends StatelessWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: Column(
        children: [
          Text(
            LocalizedTexts.yourHeight.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 48,
          ),
          const HeightTabs(),
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
    return ElevatedButton(
      onPressed: () => _onNextPressed(context),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor:
        MaterialStateProperty.all(AppColors.orangeDark),
      ),
      child: Text(LocalizedTexts.next.tr()),
    );
  }

  void _onNextPressed(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();

    // bloc.add(PhysicalFitnessEvent.heightChanged(height));

    final physicalFitnessNavigationState = PhysicalFitnessNavigationState.of(context);

    physicalFitnessNavigationState.onNextPage();
  }
}

