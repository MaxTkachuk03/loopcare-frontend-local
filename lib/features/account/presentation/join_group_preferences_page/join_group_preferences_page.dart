import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class JoinGroupPreferencesPage extends StatefulWidget {
  const JoinGroupPreferencesPage({Key? key}) : super(key: key);

  @override
  State<JoinGroupPreferencesPage> createState() => _JoinGroupPreferencesPageState();
}

class _JoinGroupPreferencesPageState extends State<JoinGroupPreferencesPage> {
  YesNoAnswer? _selectedValue;

  void _onSelected(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onNextPressedHandler() {
    // TODO save data to the server and make routing depends on page mode
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
                      LocalizedTexts.wouldYouLikeToJoinSupportGroup,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                    const SizedBox(height: 24.0),
                    Column(
                      children: YesNoAnswer.values
                          .map(
                            (YesNoAnswer value) => Column(
                              children: [
                                AppChoiceChip(
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
    );
  }
}
