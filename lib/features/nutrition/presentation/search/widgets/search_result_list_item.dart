import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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

  String get _subTitle =>
      '${item.brandName != null ? '${item.brandName} | ' : ''}${item.servingDescription != null ? '${item.servingDescription} | ' : ''}${item.calories != null ? '${item.calories} ${LocalizedTexts.kcal.tr()}' : ''}';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(item),
        child: Ink(
          color: AppColors.greenLightest,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: _subTitle.isNotEmpty ? 7.0 : 14.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showLeading)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ImageIcon(
                      item.type.icon,
                      color: AppColors.blueDarker,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.w600(item.name, style: context.textTheme.titleSmall),
                      if (_subTitle.isNotEmpty)
                        CustomText.w400(_subTitle, style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: AppColors.blueDarker, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
