import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';

const double kExpandedHeight = 270.0;
const double _kCollapsedHeight = kToolbarHeight;

class FlexibleHeader extends StatefulWidget {
  final bool innerBoxIsScrolled;
  final TabController tabController;
  final ScrollController scrollController;

  const FlexibleHeader({
    super.key,
    required this.innerBoxIsScrolled,
    required this.tabController,
    required this.scrollController,
  });

  @override
  FlexibleHeaderState createState() => FlexibleHeaderState();
}

class FlexibleHeaderState extends State<FlexibleHeader> {
  final ValueNotifier<bool> showTitle = ValueNotifier(false);

  bool get _isAppBarCollapsed {
    return widget.scrollController.hasClients && widget.scrollController.offset > (kExpandedHeight - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() => showTitle.value = _isAppBarCollapsed);
  }

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
                url: images.first.trim(),
                imageBoxFit: BoxFit.cover,
              );
            }

            return SliverAppBar(
              primary: true,
              expandedHeight: kExpandedHeight,
              collapsedHeight: _kCollapsedHeight,
              toolbarHeight: kToolbarHeight,
              pinned: true,
              floating: true,
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomFilledIconButton.fromColor(color: AppColors.greenLightestTrans),
              ),
              title: ValueListenableBuilder<bool>(
                valueListenable: showTitle,
                builder: (context, show, _) {
                  return AnimatedOpacity(
                    opacity: show ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: CustomText.w700(
                      LocalizedTexts.recipeDetails.tr(),
                      style: context.textTheme.titleLarge,
                    ),
                  );
                },
              ),
              centerTitle: true,
              titleTextStyle: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              automaticallyImplyLeading: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.greenRegular,
              ),
              elevation: 0.0,
              backgroundColor: AppColors.greenOffRegular,
              forceElevated: widget.innerBoxIsScrolled,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Opacity(
                    opacity: _getOpacity(constraints.maxHeight),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      stretchModes: const <StretchMode>[],
                      background: background,
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

  double _getOpacity(double currentHeight) {
    const double offset = kExpandedHeight / 2;
    double opacity = (currentHeight - offset) / (kExpandedHeight - offset);
    if (opacity < 0.1) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    return opacity;
  }
}
