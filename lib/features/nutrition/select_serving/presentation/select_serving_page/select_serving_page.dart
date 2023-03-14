import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/nutrition_instructions/domain/dialog_filter.dart';
import 'package:loopcare_frontend/features/nutrition/select_serving/presentation/widgets/favourite_btn/favourite_btn.dart';
import 'package:loopcare_frontend/features/nutrition/select_serving/presentation/widgets/servings_list/servings_list.dart';

class SelectServingPage extends StatefulWidget {
  const SelectServingPage({Key? key}) : super(key: key);

  @override
  State<SelectServingPage> createState() => _SelectServingPageState();
}

class _SelectServingPageState extends State<SelectServingPage> {
  late bool _isFavourite;

  @override
  void initState() {
    // TODO get value from the foodItem
    _isFavourite = true;
    // TODO: make a request to get ServingTypes for the foodItem
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.headline5?.copyWith(
              color: AppColors.white,
            ),
        title: const Text('Food Item name'),
        backgroundColor: AppColors.blueAppBar,
        actions: [
          FavouriteBtn(
            isActive: _isFavourite,
            onPress: _onFavouritePressed,
          ),
        ],
      ),
      body: ServingList(),
    );
  }

  _onAddAsFavouriteConfirmedPressed() {
    // TODO send request to the server to add foodItem to the favourites
  }

  _onFavouritePressed() {
    ModalBottomSheet.filterDialog(
      context: context,
      title: LocalizedTexts.addAsFavourite.translation,
      subtitle: 'Chicken roasted or grilled serving: 1 piece (150 g)',
      onConfirmed: _onAddAsFavouriteConfirmedPressed,
      list: const [
        DialogFilter(id: 0, name: 'Breakfast', selected: false),
        DialogFilter(id: 1, name: 'Lunch', selected: false),
        DialogFilter(id: 2, name: 'Dinner', selected: false),
        DialogFilter(id: 3, name: 'Inbetweens & snacks', selected: false),
        DialogFilter(id: 4, name: 'Drinks ', selected: false),
      ],
      onChanged: (bool value, int id) {},
    );
  }
}
