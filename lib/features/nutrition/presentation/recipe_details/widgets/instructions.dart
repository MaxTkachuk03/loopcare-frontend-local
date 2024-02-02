import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            return MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20.0),
                  CustomText.bitter600(
                    s.recipe.name,
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20.0),
                  CustomText.w700(
                    LocalizedTexts.howToPrepare.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: s.recipe.directions.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final item = s.recipe.directions[index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText.w400(
                                  '${item.number}.',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(
                                  child: CustomText.w400(
                                    item.description,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ),
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
