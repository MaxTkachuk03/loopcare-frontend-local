import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class FooterOverlay extends StatelessWidget {
  const FooterOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = 2; // TODO: get items length from bloc

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
          Text(
            '$count ${count > 1 ? LocalizedTexts.items.tr() : LocalizedTexts.item.tr()} ${LocalizedTexts.selected.tr()}',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _onDeselectAll,
                  child: Text(LocalizedTexts.deselectAll.tr()),
                ),
              ),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: _onAdd,
                  child: Text(LocalizedTexts.add.tr()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onDeselectAll() {}

  void _onAdd() {}
}
