import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/allergic/widgets/allergic_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/do_not_like/widgets/do_not_like_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/types_of_food/widgets/types_of_food_chips.dart';

part 'edit_food_preferences_page.freezed.dart';

@freezed
class EditFoodPreferencesPageMode with _$EditFoodPreferencesPageMode {
  const factory EditFoodPreferencesPageMode.hates() = Hates;

  const factory EditFoodPreferencesPageMode.allergies() = Allergies;

  const factory EditFoodPreferencesPageMode.dislikes() = Dislikes;
}

class EditFoodPreferencesPage extends StatelessWidget {
  final EditFoodPreferencesPageMode mode;

  const EditFoodPreferencesPage({
    super.key,
    required this.mode,
  });

  get _title {
    return mode.map(
      hates: (_) => LocalizedTexts.dontEat,
      allergies: (_) => LocalizedTexts.youAndFoodItemThree,
      dislikes: (_) => LocalizedTexts.dontLike,
    );
  }

  get content {
    return mode.map(
        hates: (_) => const TypesOfFoodChips(),
        allergies: (_) => const AllergicChips(),
        dislikes: (_) => const DoYouLikeChips());
  }

  _onOkHandler(BuildContext context) {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.saveFoodPreferences());
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueAppBar,
        leading: const BackButtonHexagon(),
        title: Text(
          _title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
        ).tr(),
      ),
      body: SafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Expanded(child: ScrollableContainer(child: content)),
              Column(
                children: [
                  const SizedBox(height: 22.0),
                  ElevatedButton(
                    onPressed: () => _onOkHandler(context),
                    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.greyMid;
                          }

                          return AppColors.orangeDark;
                        },
                      ),
                    ),
                    child: const Text(LocalizedTexts.confirm).tr(),
                  ),
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
