import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/live_together_chips.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class BuddyLiveTogetherPage extends StatelessWidget {
  const BuddyLiveTogetherPage({super.key});

  void _onNextHandler(BuildContext context) => context.router.pushNamed(AppRoutes.buddyRelation);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      withBg: false,
      color: AppColors.blueLightest,
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.buddyPreferences.tr(),
        subtitle: LocalizedTexts.stepCounter.tr({'currentStep': 1, 'totalSteps': 3}),
        leading: CustomFilledIconButton.leadingBlueLighter(),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(72),
          child: ProgressBar(
            backgroundColor: AppColors.blueRegular,
            progressFillColor: AppColors.white,
            progressEmptyColor: AppColors.blueLighter,
            segments: 3,
            value: 1,
            progress: 1,
          ),
        ),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 35),
                    CustomText.bitter500(
                      LocalizedTexts.buddyLiveTogetherTitle.tr(),
                      textAlign: TextAlign.start,
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 28),
                    const LiveTogetherChips(),
                  ],
                ),
                BlocBuilder<BuddyBloc, BuddyState>(
                  builder: (BuildContext context, state) => Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: CustomElevatedButton.blueFullWidth(
                      onPressed:
                          state.data.liveTogether != null ? () => _onNextHandler(context) : null,
                      label: LocalizedTexts.next.tr(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
