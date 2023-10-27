import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/sliver_recipe_app_bar_delegate.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/ingredients.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/instructions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/recipe_details_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({Key? key}) : super(key: key);

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  void initState() {
    final recipeId = context.read<RecipeBloc>().state.externalRecipeId;

    if (recipeId != null) {
      context.read<RecipeDetailsBloc>().add(
            RecipeDetailsEvent.fetchOriginRecipe(int.parse(recipeId)),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loading: (_) {
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
            return DefaultTabController(
              length: 3,
              child: Builder(builder: (context) {
                final tabController = DefaultTabController.of(context);
                tabController.addListener(() => _logAnalytics(tabController));

                return Scaffold(
                  body: NestedScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        const RecipeDetailsAppBar(),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverRecipeAppBarDelegate(
                            TabBar(
                              tabs: [
                                Tab(text: LocalizedTexts.summary.translation),
                                Tab(text: LocalizedTexts.instructions.translation),
                                Tab(text: LocalizedTexts.ingredients.translation),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                    body: const SafeArea(
                      top: false,
                      child: TabBarView(
                        children: [
                          Summary(),
                          Instructions(),
                          Ingredients(),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
          orElse: () => const Scaffold(
            body: SizedBox.shrink(),
          ),
        );
      },
    );
  }

  void _logAnalytics(TabController tabController) {
    switch (tabController.index) {
      case 1:
        AnalyticsEventService.instance.logEvent('recipe_details_screen_instructions');
        break;
      case 2:
        AnalyticsEventService.instance.logEvent('recipe_details_screen_ingredients');
        break;
      default:
        AnalyticsEventService.instance.logEvent('recipe_details_screen_summary');
        break;
    }
  }
}
