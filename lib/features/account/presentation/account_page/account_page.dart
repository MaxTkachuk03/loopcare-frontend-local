import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/personal_details_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/preferences_section.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/test_results_section.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<AuthenticationCubit>().getAccount();

    super.initState();
  }

  _onLogOutPressed(BuildContext context) {
    context.read<AuthenticationCubit>().logout();
  }

  _onDeleteAccountPressed(BuildContext context) {
    ModalBottomSheet.deleteAccount(
      context: context,
      onDeleted: () {
        context.read<AuthenticationCubit>().deleteAccount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32.0),
                Text(
                  LocalizedTexts.profile,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 30.0),
                ).tr(),
                const AccountSection(),
                const PersonalDetailsSection(),
                const TestResultsSection(),
                const PreferencesSection(),
                ElevatedButton(
                  onPressed: () => _onLogOutPressed(context),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(AppColors.darkGreen),
                      ),
                  child: const Text(LocalizedTexts.signOut).tr(),
                ),
                const SizedBox(height: 21.0),
                ElevatedButton(
                  onPressed: () => _onDeleteAccountPressed(context),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(AppColors.red),
                      ),
                  child: const Text(LocalizedTexts.deleteAccount).tr(),
                ),
                const SizedBox(height: 32.0),
                const AppVersion(),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
