import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
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
              background = CachedNetworkImage(
                imageUrl: images.first ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorWidget: (_, __, ___) => const SizedBox.shrink(),
              );
            }

            return SliverAppBar(
              expandedHeight: _kExpandedHeight,
              collapsedHeight: _kCollapsedHeight,
              pinned: true,
              title: CustomText.w600(
                LocalizedTexts.recipeDetails.tr(),
                style: context.textTheme.titleLarge,
              ),
              titleTextStyle: AppBarTheme.of(context).titleTextStyle,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.all(5),
                child: CustomFilledIconButton.leadingGreenLighter(),
              ),
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
                      titlePadding: EdgeInsets.only(top: kToolbarHeight + 40),
                      title: Stack(
                        children: [
                          Positioned(
                            top: kToolbarHeight,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: background,
                          ),
                        ],
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
  const double offset = _kExpandedHeight / 3;
  double opacity = (currentHeight - offset) / (_kExpandedHeight - offset);
  if (opacity < 0.1) {
    opacity = 0;
  } else if (opacity > 1) {
    opacity = 1;
  }

  return opacity;
}
