import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class NicknamePreferencesPage extends StatefulWidget {
  const NicknamePreferencesPage({Key? key}) : super(key: key);

  @override
  State<NicknamePreferencesPage> createState() => _NicknamePreferencesPageState();
}

class _NicknamePreferencesPageState extends State<NicknamePreferencesPage> {
  final TextEditingController _nicknameController = TextEditingController();

  void _onNextPressedHandler() {
    // TODO save data to the server and make routing depends on page mode
    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setNickname(_nicknameController.text));
  }

  void _onNicknameChangeHandler(_) {
    setState(() {});
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
                      LocalizedTexts.nicknamePreferencesQuestion,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                    const SizedBox(height: 24.0),
                    TextField(
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      onChanged: _onNicknameChangeHandler,
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: LocalizedTexts.nicknamePlaceholder.tr(),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    OrangeButton(
                      onPressedHandler: _nicknameController.text.isEmpty ? null : _onNextPressedHandler,
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

  @override
  void dispose() {
    _nicknameController.dispose();

    super.dispose();
  }
}
