import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/biological_gender/widgets/biological_gender_chips.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';

class BiologicalGenderPage extends StatelessWidget {
  const BiologicalGenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      isWithOnWillPop: false,
      child: MainContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              LocalizedTexts.biologicalGenderPageTitle.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: ThemeConstants.fontSize18,
                  ),
            ),
            const SizedBox(height: 16),
            const BiologicalGenderChips(),
            const SizedBox(height: 15.0),
            // SmallOutlinedButton(
            //   text: LocalizedTexts.whyWeAreAsking.tr(),
            //   onPressed: _onWhyWeAreAskingPressed,
            // ),
          ],
        ),
      ),
    );
  }

  // void _onWhyWeAreAskingPressed() {}
}
