import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class ConsultDoctorPage extends StatelessWidget {
  const ConsultDoctorPage({super.key});

  void _onCompleteLessonHandler(BuildContext context) => context.router.pushNamed(AppRoutes.lessonComplete);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.preferences.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 38.0),
                    CustomText.bitter500(
                      LocalizedTexts.consultYourTherapist.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText.w400(
                      LocalizedTexts.consultYourTherapistBody1.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText.w400(
                      LocalizedTexts.consultYourTherapistBody2.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText.w400(
                      LocalizedTexts.consultYourTherapistBody3.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText.w400(
                      LocalizedTexts.consultYourTherapistBody4.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
                Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.completeLesson.tr(),
                      onPressed: () => _onCompleteLessonHandler(context),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
