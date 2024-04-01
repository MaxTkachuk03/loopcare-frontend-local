import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class BuddyDescriptionPage extends StatelessWidget {
  const BuddyDescriptionPage({super.key});

  void _onNextPressed(BuildContext context) => context.router.pushNamed(AppRoutes.lessonComplete);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.preferences.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32.0),
                    CustomText.bitter500(
                      LocalizedTexts.buddyDescriptionTitle.tr(),
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6.0),
                    CustomText.w400(
                      LocalizedTexts.buddyDescriptionContent.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6.0),
                  ],
                ),
                Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.next.tr(),
                      onPressed: () => _onNextPressed(context),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
