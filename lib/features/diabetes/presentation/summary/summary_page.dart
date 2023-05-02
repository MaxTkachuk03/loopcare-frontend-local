import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/editable_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.diabetes.tr()),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SuccessContainer(
                  contentPadding: EdgeInsets.zero,
                  title: LocalizedTexts.ready.tr(),
                  content: Column(
                    children: [
                      BlocBuilder<DiabetesBloc, DiabetesState>(
                          builder: (BuildContext context, state) {
                        return EditableItem(
                          title: '${LocalizedTexts.diabetes.tr()}?',
                          subtitle:
                              '${state.selectedType?.name.capitalizeOnlyFirstLetter()}',
                          routeName: DiabetesRoute.name,
                        );
                      }),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _onBackToOverviewPressed(context),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(LocalizedTexts.backToTheOverview.tr()),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBackToOverviewPressed(BuildContext context) {
    context
      ..read<DiabetesBloc>().add(const DiabetesEvent.saveDiabetesType())
      ..router.popUntilRouteWithName(PreferencesOverviewRoute.name);
  }
}
