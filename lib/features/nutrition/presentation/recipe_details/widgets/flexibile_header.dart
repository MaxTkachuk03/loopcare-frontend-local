import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';

const double _kExpandedHeight = 270.0;
const double _kCollapsedHeight = kToolbarHeight;

class FlexibleHeader extends StatefulWidget {
  final bool innerBoxIsScrolled;
  final TabController tabController;

  const FlexibleHeader({
    super.key,
    required this.innerBoxIsScrolled,
    required this.tabController,
  });

  @override
  FlexibleHeaderState createState() => FlexibleHeaderState();
}

class FlexibleHeaderState extends State<FlexibleHeader> {
  @override
  Widget build(BuildContext context) {
    Widget background;
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            final images = s.recipe.image;
            if (images == null || images.isEmpty) {
              background = Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AppImages.recipePlaceholder,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              background = NetworkImageWithCache(
                url: images.first,
                imageBoxFit: BoxFit.cover,
              );
            }

            return SliverAppBar(
              expandedHeight: _kExpandedHeight,
              collapsedHeight: _kCollapsedHeight,
              pinned: true,
              titleSpacing: 0.0,
              title: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: CustomAppBar.green(
                  title: LocalizedTexts.recipeDetails.tr(),
                  leading: CustomFilledIconButton.leadingGreenLighter(),
                ),
              ),
              titleTextStyle: AppBarTheme.of(context).titleTextStyle,
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.greenRegular,
              ),
              elevation: 0.0,
              backgroundColor: AppColors.greenRegular,
              forceElevated: widget.innerBoxIsScrolled,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Opacity(
                    opacity: _getOpacity(constraints.maxHeight),
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      stretchModes: const <StretchMode>[],
                      background: Padding(
                        padding: const EdgeInsets.only(top: kToolbarHeight),
                        child: background,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          orElse: () => const SliverToBoxAdapter(),
        );
      },
    );
  }
}

double _getOpacity(double currentHeight) {
  const double offset = _kExpandedHeight / 2;
  double opacity = (currentHeight - offset) / (_kExpandedHeight - offset);
  if (opacity < 0.1) {
    opacity = 0;
  } else if (opacity > 1) {
    opacity = 1;
  }

  return opacity;
}
