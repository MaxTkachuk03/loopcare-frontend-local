import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class MindViewContent extends StatelessWidget {
  const MindViewContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.itemCount,
    required this.itemBuilder,
    this.isLoading = false,
    this.description,
    this.listTitle,
    this.onLearnMorePressed,
    this.videoPreview,
    this.onVideoPressed,
  });

  final bool isLoading;
  final String title;
  final String subtitle;
  final String? description;
  final String? listTitle;
  final Color textColor;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function()? onLearnMorePressed;
  final String? videoPreview;
  final void Function()? onVideoPressed;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Loader();
    }

    return MainContainer(
      child: CustomScrollView(
        slivers: [
          // Title -->
          SliverPadding(
            padding: const EdgeInsets.only(top: 30),
            sliver: SliverToBoxAdapter(
              child: CustomText.bitter600(
                title,
                style: context.textTheme.displaySmall?.copyWith(color: textColor),
              ),
            ),
          ),
          // Subtitle -->
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: CustomText.bitter500(
                subtitle,
                style: context.textTheme.displayMedium?.copyWith(color: textColor),
              ),
            ),
          ),
          // Short Description -->
          if (description != null)
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: CustomText.w400(
                description!,
                style: context.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
          ),
          // Explanation button -->
          if (videoPreview != null)
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: InkWell(
                  onTap: onVideoPressed,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: NetworkImageWithCache(url: videoPreview!),
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.yellowRegular,
                          ),
                          child: SizedBox.square(
                            dimension: 54,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomElevatedButton.yellowSmall(
                    label: LocalizedTexts.learnMoreButton.tr(),
                    onPressed: onLearnMorePressed,
                  ),
                ),
              ),
            ),
          if (listTitle != null)
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: CustomText.bitter500(
                  listTitle!,
                  style: context.textTheme.displayMedium?.copyWith(color: textColor),
                ),
              ),
            ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 20),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              itemBuilder,
              childCount: itemCount,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 30)),
        ],
      ),
    );
  }
}
