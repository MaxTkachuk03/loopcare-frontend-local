import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/widgets/allergic_chips.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/widgets/do_not_like_chips.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/widgets/types_of_food_chips.dart';

part 'edit_food_preferences_page.freezed.dart';

@freezed
class EditFoodPreferencesPageMode with _$EditFoodPreferencesPageMode {
  const factory EditFoodPreferencesPageMode.hates() = Hates;

  const factory EditFoodPreferencesPageMode.allergies() = Allergies;

  const factory EditFoodPreferencesPageMode.dislikes() = Dislikes;
}

@RoutePage()
class EditFoodPreferencesPage extends StatelessWidget {
  final EditFoodPreferencesPageMode mode;
  final bool fromLessonComplete;

  const EditFoodPreferencesPage({
    super.key,
    required this.mode,
    required this.fromLessonComplete,
  });

  get _title {
    return mode.map(
      hates: (_) => LocalizedTexts.dontEat.tr(),
      allergies: (_) => LocalizedTexts.youAndFoodItemThree.tr(),
      dislikes: (_) => LocalizedTexts.dontLike.tr(),
    );
  }

  get _header {
    return mode.map(
      hates: (_) => LocalizedTexts.iDoNotEatOrDrink.tr(),
      allergies: (_) => LocalizedTexts.iAmAllergicTo.tr(),
      dislikes: (_) => LocalizedTexts.iDoNotLike.tr(),
    );
  }

  get content {
    return mode.map(
        hates: (_) => TypesOfFoodChips(fromLessonComplete: fromLessonComplete),
        allergies: (_) => AllergicChips(fromLessonComplete: fromLessonComplete),
        dislikes: (_) => DoYouLikeChips(fromLessonComplete: fromLessonComplete));
  }

  _onOkHandler(BuildContext context) {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.saveFoodPreferences());

    context.router.maybePop();
  }

  _onNextHandler(BuildContext context) {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.saveFoodPreferences());

    mode.map(
      allergies: (_) {
        context.router.push(
          EditFoodPreferencesRoute(
            mode: const EditFoodPreferencesPageMode.hates(),
            fromLessonComplete: true,
          ),
        );
      },
      hates: (_) {
        context.router.push(
          EditFoodPreferencesRoute(
            mode: const EditFoodPreferencesPageMode.dislikes(),
            fromLessonComplete: true,
          ),
        );
      },
      dislikes: (_) {
        context.router.pushNamed(AppRoutes.lessonComplete);
      },
    );
  }

  Widget _getCustomButton(BuildContext context) {
    if (fromLessonComplete) {
      return CustomElevatedButton.blueFullWidth(
        onPressed: () => _onNextHandler(context),
        label: LocalizedTexts.next.tr(),
      );
    }

    return CustomElevatedButton.blueFullWidth(
      onPressed: () => _onOkHandler(context),
      label: LocalizedTexts.confirm.tr(),
    );
  }

  CustomAppBar _getCustomAppBar() {
    if (fromLessonComplete) {
      return CustomAppBar.petrol(
        title: _title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      );
    }
    return CustomAppBar.blue(
      title: _title,
      leading: CustomFilledIconButton.leadingBlueLighter(),
    );
  }

  CustomScaffold _getCustomScaffold({
    Widget? body,
  }) {
    if (fromLessonComplete) {
      return CustomScaffold.petrolLightest(
        appBar: _getCustomAppBar(),
        body: body,
      );
    }
    return CustomScaffold.blueLightest(
      appBar: _getCustomAppBar(),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getCustomScaffold(
      body: CustomSafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomText.bitter500(
                  _header,
                  style: context.textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 22.0),
              Expanded(
                child: ScrollableContainer(child: content),
              ),
              Column(
                children: [
                  const SizedBox(height: 22.0),
                  _getCustomButton(context),
                  const SizedBox(height: 30.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
