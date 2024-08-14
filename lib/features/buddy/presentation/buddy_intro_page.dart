import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

@RoutePage()
class BuddyIntroPage extends StatelessWidget {
  final RiverModuleStreamType streamType;

  const BuddyIntroPage({super.key, required this.streamType});

  void _onYesPressed(BuildContext context) =>
      context.router.push(BuddyDescriptionRoute(streamType: streamType));

  void _onLaterPressed(BuildContext context) =>
      context.router.push(LessonCompleteRoute(streamType: streamType));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: streamType.lightestColor,
      appBar: CustomAppBar(
        backgroundColor: streamType.regularColor,
        textTheme: streamType.appBarTextTheme,
        title: LocalizedTexts.preferences.tr(),
        leading: CustomFilledIconButton.fromColor(color: streamType.lighterColor),
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
                    const Center(child: Image(image: AppImages.buddyIntro)),
                    const SizedBox(height: 28.0),
                    CategoryLabel.buddy(),
                    const SizedBox(height: 18.0),
                    CustomText.bitter600(
                      LocalizedTexts.buddyIntroTitle.tr(),
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18.0),
                    CustomText.w400(
                      '${LocalizedTexts.buddyIntroBody.tr()}.',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 18.0),
                  ],
                ),
                Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.buddyIntroYesBtn.tr(),
                      onPressed: () => _onYesPressed(context),
                    ),
                    const SizedBox(height: 12.0),
                    CustomOutlinedButton.blueFullWidth(
                      label: LocalizedTexts.buddyIntroNoBtn.tr(),
                      onPressed: () => _onLaterPressed(context),
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
