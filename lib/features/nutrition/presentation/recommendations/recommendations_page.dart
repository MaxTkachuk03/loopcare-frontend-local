import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loopcare_frontend/core/presentation/app_bar/green_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recommendations/recommendations_carousel.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class RecommendationsPage extends StatelessWidget {
  final String mealCategory;
  final DateTime date;

  const RecommendationsPage({
    Key? key,
    required this.mealCategory,
    required this.date,
  }) : super(key: key);

  _emptyListListener(BuildContext context, RecipeState state) {
    context.router.replace(SelectFoodRoute(mealCategory: mealCategory));
  }

  _onSkipPressed(BuildContext context) {
    context.router.push(SelectFoodRoute(mealCategory: mealCategory));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeBloc, RecipeState>(
      listenWhen: (prev, cur) => cur.data.recommendationRecipe.isEmpty,
      listener: _emptyListListener,
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loadingRecipe: (_) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButtonHexagon(
                  background: AppColors.white.withOpacity(0.2),
                ),
              ),
              body: const Loader(),
            );
          },
          recipeInfo: (s) {
            return Scaffold(
              body: SafeArea(
                top: false,
                child: ScrollableContainer(
                  child: Column(
                    children: [
                      GreenAppBar(
                        title: LocalizedTexts.recommended.translation,
                        subtitle: mealCategory,
                        darkGreen: true,
                      ),
                      SizedBox(
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RecommendationsCarousel(
                            recommendations: state.data.recommendationRecipe,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 26.0),
                          MainContainer(
                            child: ElevatedButton(
                              onPressed: () => _onSkipPressed(context),
                              child: Text(LocalizedTexts.skip.translation),
                            ),
                          ),
                          const SizedBox(height: 20.0)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () => Scaffold(
            body: SafeArea(
              top: false,
              child: ScrollableContainer(
                child: Column(
                  children: [
                    GreenAppBar(
                      title: LocalizedTexts.recommended.translation,
                      subtitle: mealCategory,
                      darkGreen: true,
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 26.0),
                        MainContainer(
                          child: ElevatedButton(
                            onPressed: () => _onSkipPressed(context),
                            child: Text(LocalizedTexts.skip.translation),
                          ),
                        ),
                        const SizedBox(height: 20.0)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
