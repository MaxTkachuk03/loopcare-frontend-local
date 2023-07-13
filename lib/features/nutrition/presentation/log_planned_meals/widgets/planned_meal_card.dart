import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class PlannedMealCard extends StatelessWidget {
  const PlannedMealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0, bottom: 34.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lunch',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blueAppBar),
          ),
          const SizedBox(
            height: 18.0,
          ),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Text('items'),
          ),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            onPressed: _onLogMealPressed,
            style: Theme.of(context)
                .elevatedButtonTheme
                .style
                ?.copyWith(minimumSize: MaterialStateProperty.all(const Size(146, 40))),
            child: const Text(LocalizedTexts.logAs).tr(
              namedArgs: {
                'logAs': 'lunch',
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onLogMealPressed() {}
}
