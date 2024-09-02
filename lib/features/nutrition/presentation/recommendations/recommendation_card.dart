import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recommendations/recommendation_recipe.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recommendations/show_block.dart';

class RecommendationCard extends StatelessWidget {
  final RecommendationRecipe recommendation;

  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final image = recommendation.image?.first;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 225.0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: image != null
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(image),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AppImages.recipePlaceholder,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      recommendation.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 16.0,
              right: 16.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
                const SizedBox(height: 18.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SummaryItem(
                        label: LocalizedTexts.cookingTime.tr(),
                        icon: AppIcons.clockGrey,
                        quantity: '${recommendation.cookingTimeMin}',
                        quantityLabel: 'min',
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: SummaryItem(
                        label: LocalizedTexts.preparationTime.tr(),
                        icon: AppIcons.clockGrey,
                        quantity: '${recommendation.preparationTimeMin}',
                        quantityLabel: 'min',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ShowBlock(
                        onPress: () => _onPressHandler(
                          context: context,
                          recipeId: recommendation.id,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPressHandler({required BuildContext context, required int recipeId}) {
    context.read<RecipeBloc>().add(RecipeEvent.fetchRecipe(recipeId));

    context.router.push(RecipeDetailsRoute(fromRecommendation: true));
  }
}
