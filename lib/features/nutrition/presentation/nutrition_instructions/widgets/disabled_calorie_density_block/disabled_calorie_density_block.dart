import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class DisabledCalorieDensityBlock extends StatelessWidget {
  const DisabledCalorieDensityBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 15.0,
          height: 55.0,
          child: CalorieDensityScale(
            layout: CalorieDensityScaleLayout.vertical,
            separatorColor: AppColors.bgGreen,
            separatorSize: 1,
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizedTexts.calorieDensity.translation.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 12.0,
                  ),
            ),
            Text(
              '-',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
