import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/sliver_recipe_app_bar_delegate.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/ingredients.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/instructions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({Key? key}) : super(key: key);

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  void initState() {
    final recipeId = context.read<RecipeBloc>().state.recipeId;

    if (recipeId != null) {
      context.read<RecipeDetailsBloc>().add(
            RecipeDetailsEvent.fetchOriginRecipe(recipeId),
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
              appBar: AppBar(),
              body: const Loader(),
            );
          },
          recipeInfo: (s) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 160.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            s.recipe.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                          ),
                          background: Image.network(
                            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: SliverRecipeAppBarDelegate(
                          TabBar(
                            tabs: [
                              Tab(text: LocalizedTexts.summary.translation),
                              Tab(text: LocalizedTexts.instructions.translation),
                              Tab(text: LocalizedTexts.ingredients.translation),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: const TabBarView(
                    children: [
                      Summary(),
                      Instructions(),
                      Ingredients(),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () => const Scaffold(
            body: SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
