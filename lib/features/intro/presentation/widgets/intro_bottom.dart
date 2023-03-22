import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class IntroBottom extends StatelessWidget {
  const IntroBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _onGetStarted(context),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.orangeDark),
              ),
          child: Text(LocalizedTexts.getStarted.tr()),
        ),
        const SizedBox(
          height: 16.0,
        ),
        GestureDetector(
          onTap: () => _onLoginTap(context),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: '${LocalizedTexts.haveAnAccount.tr()} ',
                ),
                TextSpan(
                  text: LocalizedTexts.logIn.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.orangeMid,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  void _onGetStarted(BuildContext context) {
    context.router.pushNamed(AppRoutes.joinUs);
  }

  void _onLoginTap(BuildContext context) {
    context.router.pushNamed(AppRoutes.nutritionDashboard);
  }
}
