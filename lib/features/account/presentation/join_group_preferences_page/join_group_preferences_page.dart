import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/domain/consult_doctor_page_mode.dart';

class JoinGroupPreferencesPage extends StatefulWidget {
  // TODO route is called only from one place with false value, so we don't need it as a param cause it always the same
  final bool fromLessonComplete;

  const JoinGroupPreferencesPage({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<JoinGroupPreferencesPage> createState() => _JoinGroupPreferencesPageState();
}

class _JoinGroupPreferencesPageState extends State<JoinGroupPreferencesPage> {
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
      context.router.pop();
    } else {
      AnalyticsEventService.instance.logEvent(
        FirebaseEvents.iWantToJoinToGroup,
        parameters: {
          CustomDefinitions.navigatedFrom: widget.fromLessonComplete ? 'Lesson content' : 'User profile',
        },
      );

      if (context.read<AuthenticationCubit>().state.isTreatedByPsychiatrist) {
        context.router.push(ConsultDoctorRoute(mode: const ConsultDoctorPageMode.userProfile()));
        return;
      }

      context.router.push(GenderPreferencesRoute(fromLessonComplete: widget.fromLessonComplete));
    }

    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setWouldLikeJoinGroup(_selectedValue!));
  }

  @override
  Widget build(BuildContext context) {
    return GroupPrefsPageWrap(
      fromLessonComplete: widget.fromLessonComplete,
      child: SafeArea(
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
