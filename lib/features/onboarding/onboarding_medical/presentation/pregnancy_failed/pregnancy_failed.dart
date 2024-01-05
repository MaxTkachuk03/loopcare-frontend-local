import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class PregnancyFailedPage extends StatelessWidget {
  const PregnancyFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.bodyAndMind.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              UnderAppbar.blue(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65.0),
                    child: CustomText.bitter600(
                      LocalizedTexts.failedPregnancyTitle.tr(),
                      style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              MainContainer(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        CustomText.w600(
                          LocalizedTexts.failedPregnancyBody1.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          LocalizedTexts.failedPregnancyBody2.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          LocalizedTexts.failedPregnancyBody3.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          LocalizedTexts.failedPregnancyBody4.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _onMoreInfoPressed() {}
}
