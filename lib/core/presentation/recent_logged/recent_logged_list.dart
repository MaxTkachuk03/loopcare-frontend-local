import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/recent_logged/recent_logged_item.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

class RecentLoggedList extends StatelessWidget {
  final RecentLoggedItem item;
  final Function(RecentLoggedItem item) onTap;
  final bool showLeading;

  const RecentLoggedList({
    super.key,
    required this.item,
    required this.onTap,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final itemIcon = item.type == SearchItemTypes.recipe.name
        ? SearchItemTypes.recipe.icon
        : item.type == SearchItemTypes.food.name
            ? SearchItemTypes.food.icon
            : SearchItemTypes.dish.icon;
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.greenLightest,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showLeading)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ImageIcon(
                        itemIcon,
                        color: AppColors.blueDarker,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.w600(
                          item.name,
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: AppColors.blueDarker, size: 16),
                ],
              ),
            ),
            const Divider(color: AppColors.blueLighter, height: 1, thickness: 1)
          ],
        ),
      ),
    );
  }
}
