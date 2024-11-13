import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_page_mode.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class JoinGroupPreferencesPage extends StatefulWidget {
  const JoinGroupPreferencesPage({super.key});

  @override
  State<JoinGroupPreferencesPage> createState() => _JoinGroupPreferencesPageState();
}

class _JoinGroupPreferencesPageState extends State<JoinGroupPreferencesPage> {
  final account = getIt<SharedStorageService>().account;
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    _selectedValue = context.read<GroupPreferencesBloc>().state.data.wouldLikeJoinGroup;

    super.initState();
  }

  void _onSelected(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onNextPressedHandler() {
    if (_selectedValue == YesNoAnswer.no) {
      context.router.maybePop();
    } else {
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.iWantToJoinToGroup,
        parameters: {
          AnalyticsParameters.navigatedFrom: 'User profile',
        },
      );

      if (account!.isOnTrial) {
        context.router
            .push(NeedPaidSubscriptionRoute(mode: const ExtraActionPageMode.userProfile()));
        return;
      }

      if (account?.medicalOnboarding?.treatedByPsychiatrist ?? false) {
        context.router.push(ConsultDoctorRoute(mode: const ExtraActionPageMode.userProfile()));
        return;
      }

      context.router.pushNamed(AppRoutes.genderPreferences);
    }

    context
        .read<GroupPreferencesBloc>()
        .add(GroupPreferencesEvent.setWouldLikeJoinGroup(_selectedValue!));
  }

  @override
  Widget build(BuildContext context) {
    return GroupPrefsPageWrap(
      child: CustomSafeArea(
        child: MainContainer(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 28.0),
                    CustomText.bitter500(
                      LocalizedTexts.wouldYouLikeToJoinSupportGroup.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 24.0),
                    Column(
                      children: YesNoAnswer.values
                          .map(
                            (YesNoAnswer value) => Column(
                              children: [
                                CustomChoiceChip.coral(
                                  label: value.label,
                                  selected: value == _selectedValue,
                                  value: value,
                                  onSelected: _onSelected,
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
                Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      onPressed: _selectedValue == null ? null : _onNextPressedHandler,
                      label: LocalizedTexts.next.tr(),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
