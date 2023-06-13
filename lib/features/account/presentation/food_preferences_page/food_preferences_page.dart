import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class FoodPreferencesPage extends StatelessWidget {
  const FoodPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocalizedTexts.foodPreferences,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 30.0),
                ).tr(),
                const SizedBox(height: 20.0),
                BlocBuilder<YouAndFoodBloc, YouAndFoodState>(builder: (BuildContext context, state) {
                  return Column(
                    children: [
                      SectionItem(
                        title: LocalizedTexts.iDoNotEatOrDrink,
                        subTitle: state.selectedHatesNames.join(', '),
                        onPressHandler: () => context.router
                            .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.hates())),
                      ),
                      const SizedBox(height: 10.0),
                      SectionItem(
                        title: LocalizedTexts.iAmAllergicTo,
                        subTitle: state.selectedAllergicNames.join(', '),
                        onPressHandler: () => context.router.push(
                            EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.allergies())),
                      ),
                      const SizedBox(height: 10.0),
                      SectionItem(
                        title: LocalizedTexts.iDoNotLike,
                        subTitle: state.selectedDislikesNames.join(', '),
                        onPressHandler: () => context.router.push(
                            EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.dislikes())),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
