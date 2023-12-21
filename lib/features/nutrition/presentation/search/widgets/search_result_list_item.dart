import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

class SearchResultListItem extends StatelessWidget {
  final SearchItem item;
  final Function(SearchItem item) onTap;
  final bool showLeading;

  const SearchResultListItem({
    super.key,
    required this.item,
    required this.onTap,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(item),
        child: Ink(
          color: AppColors.greenLightest,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showLeading)
                            Padding(
                              padding: const EdgeInsets.only(left: 9, right: 15),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: ImageIcon(
                                  item.type.icon,
                                  color: AppColors.blueDarker,
                                ),
                              ),
                            ),
                          Expanded(
                            child: CustomText.w600(
                              item.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const ImageIcon(
                            AppIcons.arrow,
                            color: AppColors.blueDarker,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.blueLighter, height: 1, thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
