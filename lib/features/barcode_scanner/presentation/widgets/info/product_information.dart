import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ProductInformation extends StatelessWidget {
  final String title;

  const ProductInformation({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
              IconButton(
                onPressed: () => {
                  context.router.pop(),
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Calories: 80'),
                Text('Per serving : 100 g'),
              ]),
        ),
        OutlinedButton(
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                side: MaterialStateProperty.all(
                    const BorderSide(width: 1.0, color: AppColors.black)),
              ),
          onPressed: () => context.router.pop(),
          child: Text(LocalizedTexts.scanOtherProduct.tr()),
        ),
        const SizedBox(height: 14),
        OutlinedButton(
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                side: MaterialStateProperty.all(
                    const BorderSide(width: 1.0, color: AppColors.blueDark)),
                backgroundColor: MaterialStateProperty.all(AppColors.blueDark),
              ),
          onPressed: () => context.router.pop(),
          child: Text(
            LocalizedTexts.continueBtn.tr(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
