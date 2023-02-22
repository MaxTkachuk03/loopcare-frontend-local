import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list_item.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class Pref {
  final String title;
  final String completionTime;
  final bool isCompleted;
  final AssetImage imagePath;

  Pref({
    required this.title,
    required this.completionTime,
    required this.isCompleted,
    required this.imagePath,
  });
}

class PreferencesList extends StatefulWidget {
  const PreferencesList({Key? key}) : super(key: key);

  @override
  State<PreferencesList> createState() => _PreferencesListState();
}

class _PreferencesListState extends State<PreferencesList> {
  @override
  void initState() {
    context
        .read<YouAndFoodBloc>()
        .add(const YouAndFoodEvent.fetchFoodPreferences());

    context.read<DiabetesBloc>().add(const DiabetesEvent.getUserDiabetesType());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            PreferencesListItem(
              item: Pref(
                title: 'Food temptations',
                completionTime: '10 ${LocalizedTexts.minutes.tr()}',
                isCompleted: false,
                imagePath: AppImages.preferencesDiabetes,
              ),
              imageOverlayColor: AppColors.orange.withOpacity(0.8),
              routePath: AppRoutes.householdIntro,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
        BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
            builder: (BuildContext context, state) {
          return Column(
            children: [
              PreferencesListItem(
                item: Pref(
                  title: LocalizedTexts.foodTemptations.tr(),
                  completionTime: '10 ${LocalizedTexts.minutes.tr()}',
                  isCompleted: state.isCompleted,
                  imagePath: AppImages.youAndFoodIntro,
                ),
                imageOverlayColor: AppColors.blueLight.withOpacity(0.8),
                routePath: AppRoutes.youAndFoodIntro,
              ),
              const SizedBox(height: 8.0),
            ],
          );
        }),
        Column(
          children: [
            PreferencesListItem(
              item: Pref(
                title: 'Food temptations',
                completionTime: '10 ${LocalizedTexts.minutes.tr()}',
                isCompleted: false,
                imagePath: AppImages.preferencesDiabetes,
              ),
              imageOverlayColor: AppColors.greenLight.withOpacity(0.8),
              routePath: AppRoutes.householdIntro,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
        Column(
          children: [
            PreferencesListItem(
              item: Pref(
                title: LocalizedTexts.householdAndEatingHabits.tr(),
                completionTime: '10 ${LocalizedTexts.minutes.tr()}',
                isCompleted: false,
                imagePath: AppImages.preferencesDiabetes,
              ),
              imageOverlayColor: AppColors.purple.withOpacity(0.8),
              routePath: AppRoutes.householdIntro,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
        BlocBuilder<DiabetesBloc, DiabetesState>(
            builder: (BuildContext context, state) {
          return Column(
            children: [
              PreferencesListItem(
                item: Pref(
                  title: LocalizedTexts.diabetes.tr(),
                  completionTime: '5 ${LocalizedTexts.minutes.tr()}',
                  isCompleted: state.isCompleted,
                  imagePath: AppImages.preferencesDiabetes,
                ),
                imageOverlayColor: AppColors.yellowish.withOpacity(0.8),
                routePath: AppRoutes.diabetes,
              ),
              const SizedBox(height: 8.0),
            ],
          );
        }),
      ],
    );
  }
}
