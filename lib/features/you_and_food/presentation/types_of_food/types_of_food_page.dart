import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/types_of_food/types_of_food_chips.dart';

class TypesOfFoodPage extends StatelessWidget {
  const TypesOfFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(LocalizedTexts.youAndFood.tr()),
            Text(
              '1 of 4',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: MainContainer(
          child: Column(
            children: [
              const SizedBox(
                height: 48.0,
              ),
              RichText(
                text: TextSpan(
                  text: '${LocalizedTexts.whichTypesOfFoodDoYou.tr()} ',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: LocalizedTexts.not.tr().toUpperCase(),
                      style:
                      Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: ' ${LocalizedTexts.eatOrDrink.tr()}',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26.0,
              ),
              const Expanded(
                child: ScrollableContainer(
                  child: TypesOfFoodChips(),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 22.0,
                  ),
                  ElevatedButton(
                    onPressed: _onNextPressed,
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.orangeDark),
                        ),
                    child: Text(LocalizedTexts.start.tr()),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNextPressed() {}
}
