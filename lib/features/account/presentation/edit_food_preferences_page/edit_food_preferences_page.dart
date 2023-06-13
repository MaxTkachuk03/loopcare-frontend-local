import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
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
    Key? key,
    required this.mode,
  }) : super(key: key);

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

  get _question {
    return mode.map(
      hates: (_) => LocalizedTexts.dontEatFoodMessage,
      allergies: (_) => LocalizedTexts.allergicQuestion,
      dislikes: (_) => LocalizedTexts.dislikeFoodMessage,
    );
  }

  _onOkHandler(BuildContext context) {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.saveFoodPreferences());
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          _title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
        ).tr(),
      ),
      body: SafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Text(
                _question,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ).tr(),
              const SizedBox(height: 26.0),
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
                    child: Text(LocalizedTexts.ok.toUpperCase()).tr(),
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
