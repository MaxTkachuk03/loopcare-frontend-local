import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  _onLogOutPressed(BuildContext context) {
    context.read<AuthenticationCubit>().logout();
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
                const SizedBox(height: 32.0),
                const SectionTitle(title: LocalizedTexts.account),
                const SectionTitle(title: LocalizedTexts.personalDetails),
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (BuildContext context, state) {
                    return SectionItem(
                        title: LocalizedTexts.name, subTitle: state.name, onPressHandler: () {});
                  },
                ),
                const SizedBox(height: 20.0),
                SectionItem(title: LocalizedTexts.height, subTitle: 'Artur', onPressHandler: () {}),
                const SizedBox(height: 20.0),
                SectionItem(title: LocalizedTexts.yourSex, subTitle: 'Artur', onPressHandler: () {}),
                const SizedBox(height: 20.0),
                const SectionTitle(title: LocalizedTexts.testResults),
                const SectionTitle(title: LocalizedTexts.preferences),
                ElevatedButton(
                  onPressed: () => _onDeleteAccountPressed(context),
                  child: const Text('Delete My Account'),
                ),
                const SizedBox(height: 21.0),
                ElevatedButton(
                  onPressed: () => _onLogOutPressed(context),
                  child: const Text('Log out'),
                ),
                const SizedBox(height: 32.0),
                const AppVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onDeleteAccountPressed(BuildContext context) {
    ModalBottomSheet.deleteAccount(
      context: context,
      onDeleted: () {
        context.read<AuthenticationCubit>().deleteAccount();
      },
    );
  }
}
