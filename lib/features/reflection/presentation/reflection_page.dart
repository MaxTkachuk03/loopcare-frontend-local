import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/green_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/activities_section.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/complete_reflection.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/intro_section.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/mind_section.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/nutrition_section.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/weight_section.dart';

class ReflectionPage extends StatelessWidget {
  const ReflectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const GreenAppBar(
        title: '4 week reflection',
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Container(
            color: AppColors.bgGreen,
            child: Column(
              children: const [
                IntroSection(),
                SizedBox(
                  height: 8.0,
                ),
                NutritionSection(),
                SizedBox(
                  height: 8.0,
                ),
                MindSection(),
                SizedBox(
                  height: 8.0,
                ),
                ActivitiesSection(),
                SizedBox(
                  height: 8.0,
                ),
                WeightSection(),
                SizedBox(
                  height: 8.0,
                ),
                CompleteReflectionSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
