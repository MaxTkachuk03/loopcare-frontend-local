import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/household_and_habits/domain/eat_place_item.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/household_and_habits_question.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/where_do_you_eat/widgets/where_do_you_eat_item.dart';

class WhereDoYouEatPage extends StatelessWidget {
  const WhereDoYouEatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HouseholdAndHabitsQuestion(
      subtitle: '4 ${LocalizedTexts.of.tr()} 6',
      question: Text(
        LocalizedTexts.whereDoYouEatQuestion.tr(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      questionList: Column(
        children: [
          WhereDoYouEatItem(
            label: LocalizedTexts.breakfast.tr(),
            list: const [
              EatPlaceItem(id: 1, name: 'At home'),
              EatPlaceItem(id: 2, name: 'At work'),
              EatPlaceItem(id: 3, name: 'Out'),
              EatPlaceItem(id: 4, name: 'In transit'),
            ],
          ),
          const Divider(color: AppColors.yellowLight, height: 2, thickness: 2),
          const SizedBox(
            height: 24.0,
          ),
          WhereDoYouEatItem(
            label: LocalizedTexts.lunch.tr(),
            list: const [
              EatPlaceItem(id: 1, name: 'At home'),
              EatPlaceItem(id: 2, name: 'At work'),
              EatPlaceItem(id: 3, name: 'Out'),
              EatPlaceItem(id: 4, name: 'In transit'),
            ],
          ),
          const Divider(color: AppColors.yellowLight, height: 2, thickness: 2),
          const SizedBox(
            height: 24.0,
          ),
          WhereDoYouEatItem(
            label: LocalizedTexts.dinner.tr(),
            list: const [
              EatPlaceItem(id: 1, name: 'At home'),
              EatPlaceItem(id: 2, name: 'At work'),
              EatPlaceItem(id: 3, name: 'Out'),
              EatPlaceItem(id: 4, name: 'In transit'),
            ],
          ),
          const Divider(color: AppColors.yellowLight, height: 2, thickness: 2),
          const SizedBox(
            height: 24.0,
          ),
          WhereDoYouEatItem(
            label: LocalizedTexts.lateDinner.tr(),
            list: const [
              EatPlaceItem(id: 1, name: 'At home'),
              EatPlaceItem(id: 2, name: 'At work'),
              EatPlaceItem(id: 3, name: 'Out'),
              EatPlaceItem(id: 4, name: 'In transit'),
            ],
          ),
        ],
      ),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {}
}
