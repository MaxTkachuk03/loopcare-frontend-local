import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';

class SearchResultGridItem extends StatelessWidget {
  final SearchItem item;
  final Function(SearchItem item) onTap;

  const SearchResultGridItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = item.image;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () => onTap(item),
          child: Ink(
            color: AppColors.white,
            child: Column(
              children: [
                Expanded(
                  child: GridTile(
                    footer: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.gridTitleGradientStart,
                            AppColors.gridTitleGradientEnd,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                        ),
                      ),
                    ),
                    child: url != null
                        ? NetworkImageWithCache(
                            url: url,
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
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
