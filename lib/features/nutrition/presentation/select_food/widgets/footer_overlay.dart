import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';

class FooterOverlay extends StatelessWidget {
  const FooterOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          right: 24.0, left: 24.0, top: 16.0, bottom: 40.0),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1, color: AppColors.yellowLight),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SelectFoodBloc, SelectFoodState>(
            builder: (BuildContext context, state) {
              final count = state.selectedFavoritesItemsLength;

              return Text(
                '$count ${count > 1 ? LocalizedTexts.items.translation : LocalizedTexts.item.translation} ${LocalizedTexts.selected.translation}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontStyle: FontStyle.italic),
              );
            },
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _onDeselectAll(context),
                  child: Text(LocalizedTexts.deselectAll.translation),
                ),
              ),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: _onAdd,
                  child: Text(LocalizedTexts.add.translation),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onDeselectAll(BuildContext context) {
    context
        .read<SelectFoodBloc>()
        .add(const SelectFoodEvent.itemsDeselectAll());
  }

  void _onAdd() {}
}
