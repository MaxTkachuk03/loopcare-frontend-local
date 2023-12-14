import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class RecipeDetailsAppBar extends StatelessWidget {
  const RecipeDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            final images = s.recipe.image;

            return SliverAppBar(
              leading: BackButtonHexagon(
                background: AppColors.white.withOpacity(0.2),
              ),
              collapsedHeight: 150,
              expandedHeight: 250,
              pinned: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Stack(
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
                        image: images != null
                            ? DecorationImage(
                                image: CachedNetworkImageProvider(images.first),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AppImages.recipePlaceholder,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          s.recipe.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          orElse: () => const SliverToBoxAdapter(),
        );
      },
    );
  }
}
