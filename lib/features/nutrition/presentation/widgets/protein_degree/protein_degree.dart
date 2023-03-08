import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';

class ProteinDegree extends StatelessWidget {
  final double proteinDegree;
  final NutritionValue currentProteinDegreeItem;

  const ProteinDegree({
    Key? key,
    required this.proteinDegree,
    required this.currentProteinDegreeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocalizedTexts.proteinDegree.translation}: $proteinDegree',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                currentProteinDegreeItem.label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blueDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                currentProteinDegreeItem.text,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocalizedTexts.whatIsProtein.translation,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              LocalizedTexts.calorieDensityExplanationOne.translation,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 16.0),
            Text(
              LocalizedTexts.calorieDensityExplanationTwo.translation,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
