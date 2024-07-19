import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflections_list.dart';

@RoutePage()
class MyReflectionsPage extends StatelessWidget {
  const MyReflectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.coral(
      appBar: CustomAppBar.coral(
        title: LocalizedTexts.reflections.tr(),
        leading: CustomFilledIconButton.leadingCoralLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: BlocBuilder<ReflectionsBloc, ReflectionsState>(
              builder: (context, state) {
                final currentWeekReflections =
                    state.data.getSelectedWeekUndoneReflections(DateTime.now());

                final pastReflections = state.data.getPastReflections(DateTime.now());

                final hasReflections =
                    currentWeekReflections.isNotEmpty || pastReflections.isNotEmpty;

                return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () {
                    if (!hasReflections) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 28.0),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 22.0),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentWeekReflections.isNotEmpty)
                                ReflectionsList(
                                  list: currentWeekReflections,
                                  title: LocalizedTexts.thisWeek.tr().capitalize(),
                                  fromDashboard: false,
                                ),
                              if (pastReflections.isNotEmpty) ...[
                                const Divider(color: AppColors.greyDarker),
                                ReflectionsList(
                                  list: pastReflections,
                                  title: LocalizedTexts.pastReflections.tr().capitalize(),
                                  fromDashboard: false,
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
