import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/personal_details_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/preferences_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/report_abuse_section.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueDark,
        title: const Text(
          LocalizedTexts.yourProfile,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ).tr(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                const AccountSection(),
                const SizedBox(height: 24.0),
                const PersonalDetailsSection(),
                const SizedBox(height: 24.0),
                // const TestResultsSection(),
                // const SizedBox(height: 24.0),
                const PreferencesSection(),
                const SizedBox(height: 24.0),
                const ReportAbuseSection(),
                const SizedBox(height: 24.0),
                EmergencyBtn(onPressHandler: () {}),
                const SizedBox(height: 32.0),
                const Center(child: AppVersion()),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
