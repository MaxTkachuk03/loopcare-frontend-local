import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/practice_lesson_list/practice_lesson_card.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../../core/presentation/practice_lesson_list/practice_lesson_card_status_types.dart';

@RoutePage()
class ReflectionsPage extends StatefulWidget {
  const ReflectionsPage({super.key});

  @override
  State<ReflectionsPage> createState() => _ReflectionsPageState();
}

class _ReflectionsPageState extends State<ReflectionsPage> {
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

                return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () {
                    return ListView.builder(
                        padding: const EdgeInsets.only(top: 28),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.data.reflections.length,
                        itemBuilder: (context, index) {
                          final reflection = state.data.reflections[index];
                          final cardStatus = reflection.unlockedAt == null &&
                                  reflection.completedAt == null
                              ? PracticeLessonCardStatusTypes.locked
                              : reflection.unlockedAt != null &&
                                      reflection.completedAt == null
                                  ? PracticeLessonCardStatusTypes.unlocked
                                  : PracticeLessonCardStatusTypes.completed;

                          return PracticeLessonCard(
                            key: ValueKey(reflection.id),
                            url: reflection.image,
                            text: reflection.title,
                            buttonText: LocalizedTexts.start.tr(),
                            status: cardStatus.name,
                            onPressed: cardStatus ==
                                    PracticeLessonCardStatusTypes.locked
                                ? null
                                : () {
                                    _onItemPressedHandler(context, reflection);
                                  },
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
