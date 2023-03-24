import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_tab_bar.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isFlashOn = false;
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: BlueAppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 8, 0, 8),
              child: Field(
                contentPadding: const EdgeInsets.only(left: 12),
                hintText: LocalizedTexts.searchHint.translation,
                controller: _searchTextController,
                isClearField: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              icon: const Icon(Icons.close, color: AppColors.white),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 8),
                  child: Text(
                    LocalizedTexts.searchFilterIn.translation,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
                UnderlinedTabBar(
                  tabs: [
                    Tab(text: LocalizedTexts.searchFilterAll.translation),
                    Tab(text: LocalizedTexts.searchFilterProducts.translation),
                    Tab(text: LocalizedTexts.searchFilterRecipes.translation),
                    Tab(text: LocalizedTexts.searchFilterMy.translation),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
