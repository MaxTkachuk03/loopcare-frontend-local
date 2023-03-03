import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ProteinDegree extends StatelessWidget {
  final proteinDegree;

  const ProteinDegree({Key? key, required this.proteinDegree})
      : super(key: key);

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
                '${LocalizedTexts.proteinDegree.translation}: 40 - 50%',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8.0),
              //TODO text from the server
              const Text(
                'TOO HIGH',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blueDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              //TODO text from the server
              Text(
                'The density of the meal you logged so far is high. A daily density at this level will make it more likely you eat in excess today.',
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
