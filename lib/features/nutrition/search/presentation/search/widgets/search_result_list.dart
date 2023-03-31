import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/search/search_result.dart';
import 'package:loopcare_frontend/features/nutrition/search/presentation/search/widgets/search_result_list_item.dart';

class SearchResultList extends StatefulWidget {
  const SearchResultList({Key? key}) : super(key: key);

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Column(
            children: [
              SearchResultListItem(
                item: SearchResult(
                  title: 'Food temptations',
                  completionTime: '10 ${LocalizedTexts.minutes.tr()}',
                  imagePath: AppImages.preferencesDiabetes.toString(),
                ),
                imageOverlayColor: AppColors.orange.withOpacity(0.8),
                routePath: AppRoutes.householdIntro,
              ),
              const SizedBox(height: 8.0),
            ],
          ),
          // BlocBuilder<SearchBloc, SearchState>(
          //     builder: (BuildContext context, state) {
          //   return Column(
          //     children: [
          //       SearchResultListItem(
          //         item: Pref(
          //           title: LocalizedTexts.foodTemptations.tr(),
          //           completionTime: '10 ${LocalizedTexts.minutes.tr()}',
          //           isCompleted: state.isCompleted,
          //           imagePath: AppImages.SearchIntro,
          //         ),
          //         imageOverlayColor: AppColors.blueLight.withOpacity(0.8),
          //         routePath: AppRoutes.SearchIntro,
          //       ),
          //       const SizedBox(height: 8.0),
          //     ],
          //   );
          // }),
        ],
      ),
    );
  }
}
