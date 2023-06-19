import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/exercise_card.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/program_footer_overlay.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/widgets/difficulty_label.dart';

const cardWidth = 166;
const cardHeight = 214;

class ProgramDetails extends StatelessWidget {
  const ProgramDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrangeAppBar(title: 'ddwddw'),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      children: [
                        DifficultyLabel(
                          text: 'easy',
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Image(
                          image: AppImages.clock,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          formatDuration(100),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'HOME'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: ThemeConstants.fontSize12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'STRENGTH'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: ThemeConstants.fontSize12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      '8 ${LocalizedTexts.exercise}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ).tr(),
                    Text('${LocalizedTexts.equipment.translation}: test'),
                    Text('${LocalizedTexts.targetMuscles.translation}: etst'),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: cardWidth / cardHeight,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return ExerciseCard(
                              index: index + 1,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            const ProgramFooterOverlay(),
          ],
        ),
      ),
    );
  }
}
