import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';

class GenderPreferencesPage extends StatefulWidget {
  final GroupPrefsMode groupPrefsMode;

  const GenderPreferencesPage({Key? key, required this.groupPrefsMode}) : super(key: key);

  @override
  State<GenderPreferencesPage> createState() => _GenderPreferencesPageState();
}

class _GenderPreferencesPageState extends State<GenderPreferencesPage> {
  GenderPreferences? _selectedValue;

  @override
  void initState() {
    _selectedValue = context.read<GroupPreferencesBloc>().state.data.genderPreferences;

    super.initState();
  }

  void _onSelected(GenderPreferences value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onNextPressedHandler() {
    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setGenderPreferences(_selectedValue!));
  }

  void _onChangeListener(BuildContext context, GroupPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  void _onErrorHandler(GroupPreferencesState state) {
    context.showErrorBar(
        content: Text(state.data.error?.error.toString() ?? ''), position: FlashPosition.top);
  }

  void _onUpdateHandler(GroupPreferencesState state) {
    if (widget.groupPrefsMode == GroupPrefsMode.flow) {
      context.router.push(TimezonePreferencesRoute(groupPrefsMode: GroupPrefsMode.flow));
    } else {
      context.router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueAppBar,
        leading: const BackButtonHexagon(),
        title: Text(
          LocalizedTexts.groupPreferences,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
        ).tr(),
      ),
      body: SafeArea(
        child: BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
          listener: _onChangeListener,
          child: MainContainer(
            child: ScrollableContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 28.0),
                      const Text(
                        LocalizedTexts.genderPreferencesQuestion,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                      const SizedBox(height: 24.0),
                      Column(
                        children: GenderPreferences.values.map(
                          (GenderPreferences value) {
                            final String gender = context.read<AuthenticationCubit>().state.gender;
                            final shouldRemoveMale =
                                gender == SexType.male.name && value == GenderPreferences.femaleOnly;
                            final shouldRemoveFemale =
                                gender == SexType.female.name && value == GenderPreferences.maleOnly;

                            if (shouldRemoveMale || shouldRemoveFemale) return const SizedBox.shrink();

                            return Column(
                              children: [
                                AppChoiceChip(
                                  label: value.label,
                                  selected: value == _selectedValue,
                                  value: value,
                                  onSelected: _onSelected,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            );
                          },
                        ).toList(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      OrangeButton(
                        onPressedHandler: _selectedValue == null ? null : _onNextPressedHandler,
                        child: const Text(LocalizedTexts.next).tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
