import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            return MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    LocalizedTexts.howToPrepare.translation,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: s.recipe.directions.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        final item = s.recipe.directions[index];

                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item.number}.'),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(child: Text(item.description))
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
