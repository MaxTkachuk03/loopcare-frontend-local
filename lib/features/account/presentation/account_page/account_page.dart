import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/personal_details_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/preferences_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/report_abuse_section.dart';
import 'package:loopcare_frontend/features/account/presentation/subscription_page/widgets/subscription_sactions.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.fetchFoodPreferences());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.yourProfile.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: const SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.0),
                AccountSection(),
                SizedBox(height: 24.0),
                PersonalDetailsSection(),
                SizedBox(height: 24.0),
                SubscriptionSection(),
                SizedBox(height: 24.0),
                // const TestResultsSection(),
                // const SizedBox(height: 24.0),
                PreferencesSection(),
                SizedBox(height: 24.0),
                ReportAbuseSection(),
                SizedBox(height: 24.0),
                // EmergencyBtn(onPressHandler: () {}),
                SizedBox(height: 32.0),
                Center(child: AppVersion()),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
