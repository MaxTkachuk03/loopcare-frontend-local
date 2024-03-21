import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_info_card.dart';
import 'package:provider/provider.dart';

class BuddyCompletedPage extends StatelessWidget {
  const BuddyCompletedPage({super.key});

  void _onNextHandler(BuildContext context) {
    context.read<BuddyBloc>().add(const BuddyEvent.inviteBuddy());
    context.router.popUntilRouteWithName(BuddyPreferencesRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.buddyPreferences.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UnderAppbar.blue(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                              backgroundColor: AppColors.greenRegular,
                              child: Icon(Icons.check, size: 24, color: AppColors.white),
                            ),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              '${LocalizedTexts.buddyCompleted.tr()}!',
                              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  MainContainer(
                    child: AccountContainer(
                      child: BuddyInfoCard(
                        title: LocalizedTexts.buddyCompletedContent.tr(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              MainContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: () => _onNextHandler(context),
                    label: LocalizedTexts.continueBtn.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
