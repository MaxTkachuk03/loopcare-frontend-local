import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

class RecipeButtonLayout extends StatefulWidget {
  final SearchListLayout selectedLayout;
  final Function(SearchListLayout value) onSelectLayoutTap;

  const RecipeButtonLayout(
      {super.key, required this.selectedLayout, required this.onSelectLayoutTap});

  @override
  State<RecipeButtonLayout> createState() => _RecipeButtonLayoutState();
}

class _RecipeButtonLayoutState extends State<RecipeButtonLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        width: 114,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.yellowLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                child: IconButton(
                  onPressed: () => widget.onSelectLayoutTap(SearchListLayout.detailed),
                  iconSize: 16,
                  padding: const EdgeInsets.all(0.0),
                  icon: ImageIcon(
                    AppIcons.detailsLayout,
                    color: (widget.selectedLayout == SearchListLayout.detailed)
                        ? AppColors.blueRegular
                        : AppColors.yellowLight,
                  ),
                ),
              ),
              const VerticalDivider(
                color: AppColors.yellowLight,
                thickness: 1.0,
              ),
              SizedBox(
                child: IconButton(
                  onPressed: () => widget.onSelectLayoutTap(SearchListLayout.list),
                  iconSize: 16,
                  padding: const EdgeInsets.all(0.0),
                  icon: ImageIcon(
                    AppIcons.listLayout,
                    color: (widget.selectedLayout == SearchListLayout.list)
                        ? AppColors.blueRegular
                        : AppColors.yellowLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
