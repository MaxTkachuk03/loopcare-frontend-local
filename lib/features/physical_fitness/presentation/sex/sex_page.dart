import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/sex/widgets/sex_chips.dart';

class SexPage extends StatelessWidget {
  const SexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Text(
            LocalizedTexts.yourSex.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: ThemeConstants.fontSize18,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          const SexChips(),
        ],
      ),
    );
  }
}
