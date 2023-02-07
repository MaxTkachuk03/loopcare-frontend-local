import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class YouAndFoodQuestion extends StatelessWidget {
  final Widget question;
  final Widget questionList;

  const YouAndFoodQuestion({
    Key? key,
    required this.question,
    required this.questionList,
  }) : super(key: key);

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
              question,
              const SizedBox(
                height: 26.0,
              ),
              Expanded(
                child: ScrollableContainer(
                  child: questionList,
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
