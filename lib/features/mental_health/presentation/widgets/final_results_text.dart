import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test_type.dart';

class FinalResultsText extends StatelessWidget {
  const FinalResultsText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final gad7Result = state.data.results[MentalHealthTestType.gad7]?.interpretation;
        final phq8Result = state.data.results[MentalHealthTestType.phq8]?.interpretation;
        final phq15Result = state.data.results[MentalHealthTestType.phq15]?.interpretation;

        final allAreHigh = gad7Result == InterpretationType.high &&
            phq8Result == InterpretationType.high &&
            phq15Result == InterpretationType.high;
        final phq8IsHigh = phq8Result == InterpretationType.high;

        if (allAreHigh || phq8IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.weWouldLikeToSupportYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${LocalizedTexts.feelLimitedByMentalOrPhysicalSymptoms.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.nutrition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.exercise,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              Text(
                '\n${LocalizedTexts.youAreWelcomeToRepeatTests.translation}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          );
        }

        final phq15IsHigh = phq15Result == InterpretationType.high;
        final gad7IsHigh = gad7Result == InterpretationType.high;

        if (phq15IsHigh && gad7IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.weWouldLikeToSupportYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${LocalizedTexts.feelLimitedByAnxietyOrPhysicalSymptoms.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.nutrition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.exercise,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.mentalHealth,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              Text(
                '\n${LocalizedTexts.weAreNotOverloadYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                LocalizedTexts.pleaseAppreciateThat,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ],
          );
        }

        if (phq15IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.weWouldLikeToSupportYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${LocalizedTexts.feelLimitedByPhysicalSymptoms.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.nutrition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.exercise,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.mentalHealth,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              Text(
                '\n${LocalizedTexts.weAreNotOverloadYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                LocalizedTexts.pleaseAppreciateThat,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ],
          );
        }

        if (gad7IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.weWouldLikeToSupportYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${LocalizedTexts.feelLimitedByAnxietySymptoms.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.nutrition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.exercise,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.mentalHealth,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              Text(
                '\n${LocalizedTexts.weAreNotOverloadYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                LocalizedTexts.pleaseAppreciateThat,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ],
          );
        }

        final phq15IsModerate = phq15Result == InterpretationType.moderate;
        final gad7IsModerate = gad7Result == InterpretationType.moderate;
        final phq8IsModerate = phq8Result == InterpretationType.moderate;

        if (phq15IsModerate && gad7IsModerate && phq8IsModerate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.weWouldLikeToSupportYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${LocalizedTexts.youHaveBurdenInSeveralFields.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.nutrition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.exercise,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: Text(
                  LocalizedTexts.mentalHealth,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ),
              Text(
                '\n${LocalizedTexts.weAreNotOverloadYou.translation}\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                LocalizedTexts.pleaseAppreciateThat,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizedTexts.weTailorTheProgramToYouPersonally,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            Text(
              '\n${LocalizedTexts.theFollowingAreasAreUnlocked.translation}\n',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: Text(
                LocalizedTexts.nutrition,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: Text(
                LocalizedTexts.exercise,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: Text(
                LocalizedTexts.mentalHealth,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: Text(
                LocalizedTexts.findBuddyAndGetIntoSupportGroup,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ),
            Text(
              '\n${LocalizedTexts.weWillGuideYou.translation}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        );
      },
    );
  }
}
