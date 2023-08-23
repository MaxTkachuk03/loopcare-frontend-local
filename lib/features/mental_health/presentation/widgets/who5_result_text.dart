import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';

class WHO5ResultText extends StatelessWidget {
  const WHO5ResultText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTestType = state.data.currentTest?.type;

        if (currentTestType == null) return const SizedBox.shrink();

        final interpretation = state.data.results[currentTestType]?.interpretation;
        final text = interpretation == InterpretationType.minimal
            ? LocalizedTexts.who5ResultTestMinimal
            : LocalizedTexts.who5ResultTestHigh;

        return Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ).tr();
      },
    );
  }
}
