import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/editable_item.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/self_help/application/self_help_bloc.dart';

class SelfHelpReadyPage extends StatelessWidget {
  const SelfHelpReadyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.selfHelpTitle.tr()),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    SuccessContainer(
                      title: LocalizedTexts.ready.tr(),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          BlocBuilder<SelfHelpBloc, SelfHelpState>(
                            builder: (BuildContext context, state) {
                              return EditableItem(
                                title: LocalizedTexts.selfHelpGenderPreferences
                                    .tr(),
                                subtitle:
                                    '${state.selectedType?.name.capitalizeOnlyFirstLetter()}',
                                routeName: SelfHelpIntroRoute.name,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _onBackPressed(context),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(LocalizedTexts.backToTheOverview.tr()),
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

  _onBackPressed(BuildContext context) {
    context
      ..read<SelfHelpBloc>().add(const SelfHelpEvent.saveAccountPreferGender())
      ..router.popUntilRouteWithName(PreferencesOverviewRoute.name);
  }
}
