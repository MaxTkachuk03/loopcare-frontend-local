import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_list_content/widgets/optional_refresh_indicator.dart';

class MindListContent extends StatelessWidget {
  const MindListContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.isVideoExplanation,
    required this.itemCount,
    required this.itemBuilder,
    this.onRefresh,
    this.isLoading = false,
    this.description,
    this.listTitle,
    this.onExplanationPressed,
    this.videoPreview,
  });

  final bool isLoading;
  final bool isVideoExplanation;
  final String title;
  final String subtitle;
  final String? description;
  final String? listTitle;
  final Color textColor;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function()? onExplanationPressed;
  final Future<void> Function()? onRefresh;
  final String? videoPreview;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Loader();
    }

    return MainContainer(
      child: OptionalRefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            // Title -->
            SliverPadding(
              padding: const EdgeInsets.only(top: 30),
              sliver: SliverToBoxAdapter(
                child: CustomText.bitter600(
                  title,
                  style: context.textTheme.displayLarge?.copyWith(color: textColor),
                ),
              ),
            ),
            // Subtitle -->
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: CustomText.bitter600(
                  subtitle,
                  style: context.textTheme.bodyLarge?.copyWith(color: textColor),
                ),
              ),
            ),
            // Short Description -->
            if (description?.isNotEmpty ?? false)
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
            if (isVideoExplanation)
              SliverPadding(
                padding: const EdgeInsets.only(top: 20),
                sliver: SliverToBoxAdapter(
                  child: _VideoPreview(
                    key: ValueKey('video_preview_$videoPreview'),
                    onExplanationPressed: onExplanationPressed,
                    videoPreview: videoPreview,
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
                      onPressed: onExplanationPressed,
                    ),
                  ),
                ),
              ),
            if (listTitle != null)
              SliverPadding(
                padding: const EdgeInsets.only(top: 20),
                sliver: SliverToBoxAdapter(
                  child: CustomText.bitter600(
                    listTitle!,
                    style: context.textTheme.bodyLarge?.copyWith(color: textColor),
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
      ),
    );
  }
}

class _VideoPreview extends StatelessWidget {
  const _VideoPreview({
    super.key,
    required this.onExplanationPressed,
    required this.videoPreview,
  });

  final void Function()? onExplanationPressed;
  final String? videoPreview;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = 9 * constraints.maxWidth / 16;

        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.black45,
                      BlendMode.darken,
                    ),
                    child: NetworkImageWithCache(
                      url: videoPreview!,
                      imageBoxFit: BoxFit.cover,
                    ),
                  ),
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
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onExplanationPressed,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
