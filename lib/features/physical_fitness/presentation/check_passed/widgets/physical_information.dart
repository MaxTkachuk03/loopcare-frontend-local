import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';

class PhysicalInformation extends StatelessWidget {
  final String age;
  final String height;
  final String weight;
  final String bmi;
  final String verdict;
  final void Function() moreInfoPressed;

  const PhysicalInformation({
    Key? key,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.verdict,
    required this.moreInfoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 130),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.only(
            top: 48,
            bottom: 25,
            left: 33,
            right: 33,
          ),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocalizedTexts.age.tr()),
                      Text(LocalizedTexts.height.tr()),
                      Text(LocalizedTexts.weight.tr()),
                      Text(LocalizedTexts.bmi.tr()),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        age,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        height,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        weight,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        bmi,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                verdict,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: AppColors.blueDark),
              ),
              const SizedBox(
                height: 16,
              ),
              SmallFilledButton(
                text: LocalizedTexts.moreInfo.tr(),
                onPressed: moreInfoPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
