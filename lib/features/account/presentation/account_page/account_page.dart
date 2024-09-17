import 'package:auto_route/annotations.dart';
import 'package:customer_io/customer_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_events.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/food_preference/food_preference_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/delete_account_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/preferences_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/report_abuse_section.dart';
import 'package:loopcare_frontend/features/account/presentation/subscription_page/widgets/subscription_sactions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    final authData = context.read<AuthenticationBloc>().state.data;

    if (authData.isFoodLoggingUnlocked) {
      context.read<FoodPreferenceBloc>().add(const FoodPreferenceEvent.fetchFoodPreferences());
    }

    if (authData.isPhysicalActivitiesUnlocked) {
      context
          .read<PhysicalActivitiesPreferencesBloc>()
          .add(const PhysicalActivitiesPreferencesEvent.getPreferences());
    }

    CustomerIO.track(
      name: CIOEvents.profilePage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.yourProfile.tr(),
        leading: const SizedBox.shrink(),
      ),
      body: const CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.0),
                AccountSection(),
                SizedBox(height: 24.0),
                SubscriptionSection(),
                SizedBox(height: 24.0),
                PreferencesSection(),
                SizedBox(height: 24.0),
                ReportAbuseSection(),
                SizedBox(height: 24.0),
                DeleteAccountSection(),
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
