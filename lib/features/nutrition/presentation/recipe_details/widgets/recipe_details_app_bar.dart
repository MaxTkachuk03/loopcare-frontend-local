import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';

class RecipeDetailsAppBar extends StatelessWidget {
  const RecipeDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            final images = s.recipe.image;

            return SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: CustomFilledIconButton.leadingGreenLighter(),
                collapsedHeight: 150,
                expandedHeight: 250,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: AppColors.greenRegular,
                ),
                pinned: true,
                elevation: 0.0,
                backgroundColor: AppColors.greenRegular,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        // foregroundDecoration: const BoxDecoration(
                        //   color: Colors.transparent,
                        // ),
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
                  ],
                ),
              ),
            );
          },
          orElse: () => const SliverToBoxAdapter(),
        );
      },
    );
  }
}
