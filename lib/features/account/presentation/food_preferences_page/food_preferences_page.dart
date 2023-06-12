import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class FoodPreferencesPage extends StatefulWidget {
  const FoodPreferencesPage({Key? key}) : super(key: key);

  @override
  State<FoodPreferencesPage> createState() => _FoodPreferencesPageState();
}

class _FoodPreferencesPageState extends State<FoodPreferencesPage> {
  @override
  void initState() {
    final authState = context.read<AuthenticationCubit>().state;
    context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setInitialFoodPreferences(
          hates: authState.foodPrefHatesIds,
          allergics: authState.foodPrefAllergiesIds,
          dislikes: authState.foodPrefDislikesIds,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocalizedTexts.foodPreferences,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 30.0),
                ).tr(),
                const SizedBox(height: 20.0),
                BlocBuilder<YouAndFoodBloc, YouAndFoodState>(builder: (BuildContext context, state) {
                  print(state);
                  return SectionItem(
                    title: LocalizedTexts.iDoNotEatOrDrink,
                    subTitle: 'sd',
                    onPressHandler: () => context.router
                        .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.hates())),
                  );
                }),
                const SizedBox(height: 10.0),
                SectionItem(
                  title: LocalizedTexts.iAmAllergicTo,
                  subTitle: 'Eggs, milk, sesame seeds, wheats, apples & Lupin',
                  onPressHandler: () => context.router
                      .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.allergies())),
                ),
                const SizedBox(height: 10.0),
                SectionItem(
                  title: LocalizedTexts.iDoNotLike,
                  subTitle: 'Olives, raisins & avocado',
                  onPressHandler: () => context.router
                      .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.dislikes())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
