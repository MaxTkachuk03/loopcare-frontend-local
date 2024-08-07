import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/network_user_avatar.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  void _onLogOutPressed(BuildContext context) {
    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.initClear());
    context.read<PhysicalProgramsBloc>().add(const PhysicalProgramsEvent.init());
    context
        .read<PhysicalActivitiesPreferencesBloc>()
        .add(const PhysicalActivitiesPreferencesEvent.init());
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.logout());
  }

  void _onEmailPressedHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.updateEmail);

  void _onAvatarPressedHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.selectAvatar);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, state) {
        return AccountContainer(
          child: Column(
            children: [
              SectionTitle(title: LocalizedTexts.account.tr()),
              OccludeWrapper(
                child: Column(
                  children: [
                    const SizedBox(height: 27),
                    NetworkUserAvatar(
                      url: state.data.avatar,
                      onPressed: () => _onAvatarPressedHandler(context),
                    ),
                    SectionItem(
                      title: LocalizedTexts.name.tr(),
                      subTitle: state.data.nameCapitalised,
                      onPressHandler: () {},
                    ),
                    const Divider(height: 1.0, color: AppColors.blueLighter),
                    SectionItem(
                      title: LocalizedTexts.emailAddress.tr(),
                      subTitle: state.data.accountEmail,
                      onPressHandler: () => _onEmailPressedHandler(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0, color: AppColors.blueLighter),
              const SizedBox(height: 16.0),
              // SectionItem(title: LocalizedTexts.changePassword, onPressHandler: () {}),
              // const SizedBox(height: 16.0),
              // const Divider(height: 1.0, color: AppColors.blueLighter),
              // const SizedBox(height: 16.0),
              // SectionItemToggler(
              //   title: LocalizedTexts.useFaceOrTouchId,
              //   value: _useFaceId,
              //   onPressHandler: _onUseFaceIdToggle,
              // ),
              // const SizedBox(height: 16.0),
              // const Divider(height: 1.0, color: AppColors.blueLighter),
              // const SizedBox(height: 16.0),
              // SectionItemToggler(
              //   title: LocalizedTexts.requireLoginEachTime,
              //   value: _requireLogin,
              //   onPressHandler: _onRequireLogin,
              // ),
              // const SizedBox(height: 16.0),
              // const Divider(height: 1.0, color: AppColors.blueLighter),
              // const SizedBox(height: 16.0),
              CustomElevatedButton.coralFullWidth(
                onPressed: () => _onLogOutPressed(context),
                label: LocalizedTexts.signOut.tr(),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
