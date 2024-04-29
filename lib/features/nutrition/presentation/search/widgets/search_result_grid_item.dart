import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';

const circularRadius = 8.0;
const _titleHeight = 40.0;

class SearchResultGridItem extends StatelessWidget {
  final SearchItem item;
  final Function(SearchItem item) onTap;

  const SearchResultGridItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  String? get url => item.image?.trim();

  BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(circularRadius));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: () => onTap(item),
        highlightColor: AppColors.greenLightest,
        borderRadius: borderRadius,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: borderRadius,
                child: GridTile(
                  child: url != null
                      ? NetworkImageWithCache(
                          url: url!,
                          imageBoxFit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        )
                      : const Image(
                          image: AppImages.recipePlaceholder,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0, left: 6.0, bottom: 4.0),
              child: SizedBox(
                height: _titleHeight,
                child: CustomText.w600(
                  item.name,
                  textAlign: TextAlign.start,
                  style: context.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
