import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';

class DashboardMindWidget extends StatelessWidget {
  const DashboardMindWidget({super.key});

  void onPressHandler(BuildContext context) => context.router.pushNamed(AppRoutes.mindTechniques);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DashboardCardTitle(
            highlightColor: AppColors.petrolLightest,
            leadingIcon: AppIcons.customDashboardMind,
            title: CustomText.bitter600(
              LocalizedTexts.mindDashboardTitle.tr(),
              style: context.textTheme.headlineSmall,
            ),
            editable: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: CustomElevatedButton.petrolSmall(
              label: LocalizedTexts.mindDashboardBtn.tr(),
              onPressed: () => onPressHandler(context),
            ),
          ),
        ],
      ),
    );
  }
}
