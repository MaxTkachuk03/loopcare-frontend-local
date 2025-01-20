import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/small_card/small_card.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class MyReflectionsPageV2 extends StatelessWidget {
  const MyReflectionsPageV2({super.key});

  void _onItemPressedHandler(BuildContext context, Reflection reflectionItem) =>
      context.router.push(ReflectionsIntroRoute(
          reflectionItem: reflectionItem, fromDashboard: false));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: AppColors.white,
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.reflections.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: BlocBuilder<ReflectionsBloc, ReflectionsState>(
              builder: (context, state) {
                final currentWeekReflections =
                    state.data.getSelectedWeekUndoneReflections(DateTime.now());

                final pastReflections =
                    state.data.getPastReflections(DateTime.now());

                final hasReflections = currentWeekReflections.isNotEmpty ||
                    pastReflections.isNotEmpty;

                return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () {
                    if (!hasReflections) return const SizedBox.shrink();
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.data.reflections.length,
                        itemBuilder: (context, index) {
                          final reflection = state.data.reflections[index];
                          return SmallCard(
                            key: ValueKey(reflection.id),
                            url: reflection.image,
                            text: reflection.title,
                            isCompleted: reflection.isComplete,
                            status: reflection.unlockedAt.toString(),
                            onPressed: () =>
                                _onItemPressedHandler(context, reflection),
                          );
                        });
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
