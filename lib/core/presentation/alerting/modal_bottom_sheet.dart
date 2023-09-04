import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_numbers.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_blue.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/oval_bottom_border_clipper.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/emergency_numbers/emergency_number_card.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/booked_session_modal_content.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/not_booked_sessions_modal_content.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class ModalBottomSheet {
  ModalBottomSheet._();

  static void emailConfirmed({
    required BuildContext context,
    required void Function() onContinuePressed,
  }) {
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          height: size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50.0),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: AppImages.checkMarkGreen,
              ),
              const SizedBox(height: 24.0),
              Text(
                LocalizedTexts.emailConfirmedBottomSheetTitle.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20.0),
              Text(
                LocalizedTexts.emailConfirmedBottomSheetContent.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  context.router.pop();
                },
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                    ),
                child: Text(
                  LocalizedTexts.continueBtn.tr(),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      onContinuePressed();
    });
  }

  static void physicalInvalidMessage({
    required BuildContext context,
    required String message,
    required String btnText,
    required void Function() onBtnPress,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.orangeDark),
                ),
              ),
              const SizedBox(height: 27.0),
              ElevatedButton(
                onPressed: onBtnPress,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: MaterialStateProperty.all(AppColors.bgGreen),
                      foregroundColor: MaterialStateProperty.all(AppColors.black),
                    ),
                child: Text(btnText),
              ),
            ],
          ),
        );
      },
    );
  }

  static void deleteAccount({
    required BuildContext context,
    required void Function() onDeleted,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 32.0),
                    Text(
                      LocalizedTexts.deleteModalMessage.translation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 47.0),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.router.pop(),
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            backgroundColor: MaterialStateProperty.all(AppColors.bgGreen),
                            foregroundColor: MaterialStateProperty.all(AppColors.black),
                          ),
                      child: Text(LocalizedTexts.noCancel.translation),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ElevatedButton(
                      onPressed: onDeleted,
                      child: Text(LocalizedTexts.yesDelete.translation),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void timeWasExceeded({
    required BuildContext context,
    required void Function() onStartAgain,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 58.0, horizontal: 40.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizedTexts.youExceededTimeMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    Text(
                      LocalizedTexts.noWorriesYouCanDoItLater,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ).tr(),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: onStartAgain,
                      child: const Text(LocalizedTexts.startAgain).tr(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void deleteMeal({
    required BuildContext context,
    required void Function() onDeleted,
    required String mealCategory,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 12.0),
                    child: IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 32.0),
                            Text(
                              LocalizedTexts.deleteMealModalMessage.translation,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 47.0),
                          ],
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () => context.router.pop(),
                              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        width: 1.0,
                                        color: AppColors.blueDark,
                                      ),
                                    ),
                                  ),
                              child: Text(
                                LocalizedTexts.noCancel.translation,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.blueDark,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            ElevatedButton(
                              onPressed: onDeleted,
                              child: Text('${LocalizedTexts.remove.translation} $mealCategory'),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void consentConfirmationMoreInfo({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: AppColors.bgGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 28.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.25,
                      child: Container(
                        height: 5.0,
                        decoration: const BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.all(Radius.circular(2.5)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.yellowLight,
                  ),
                  const SizedBox(
                    height: 34.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        Text(
                          LocalizedTexts.consentConfirmationMoreInfoTitle.tr(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.consentConfirmationMoreInfoTextOne.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.consentConfirmationMoreInfoTextTwo.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.downloadInstructionWhatToAsk.tr(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: AppColors.yellowLight,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ElevatedButton(
                        onPressed: () => context.router.pop(),
                        child: Text(
                          LocalizedTexts.close.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void mentalHealthMoreInfo({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 32.0),
                      child: SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          onPressed: () => context.router.pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  Text(LocalizedTexts.mentalHealthMoreInfo,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          )).tr(
                    namedArgs: {
                      'appName': appConfig.projectName,
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void nutrientFactsDialog({
    required BuildContext context,
    required List<NutritionItem> list,
    required void Function(NutritionValuesTypes item) onSelect,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 100,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 12.0),
                    child: IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocalizedTexts.showNutritionValue.translation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      const Divider(
                        height: 2,
                        thickness: 2,
                        color: AppColors.bgGreen,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 24.0),
                    child: ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = list[index];

                        return InkWell(
                          onTap: () {
                            context.router.pop();
                            final selectedNutritionType =
                                NutritionValuesTypes.values.firstWhere((element) => element.name == item.key);
                            onSelect(selectedNutritionType);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Text(item.name),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 2.0,
                          height: 2.0,
                          color: AppColors.bgGreen,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void sessionsDialog({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                            onPressed: () => context.router.pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        state.data.topicName,
                        style: const TextStyle(
                          fontSize: ThemeConstants.fontSize24,
                          fontFamily: ThemeConstants.bitterFontFamily,
                          color: AppColors.blueDark,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      state.data.isSigned && state.data.isGroupsOnThisWeekAvailable
                          ? const BookedSessionModalContent()
                          : const NotBookedSessionsModalContent()
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void filterDialog({
    required BuildContext context,
    required String title,
    String? subtitle,
    required List<MealCategoryFilter> list,
    void Function(List<MealCategoryFilter> updatedFiltersList)? onConfirmed,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        List<MealCategoryFilter> updatedList = [...list];

        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Wrap(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 12),
                    child: IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 24.0,
                    bottom: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (subtitle != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 14.0,
                            ),
                            Text(
                              subtitle,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24.0),
                      const Divider(
                        height: 2,
                        thickness: 2,
                        color: AppColors.bgGreen,
                      ),
                      ...updatedList.map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2, color: AppColors.bgGreen),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 32.0,
                                width: 32.0,
                                child: CheckboxBlue(
                                  onChanged: (bool? value) {
                                    final index = updatedList.indexOf(item);

                                    setState(() {
                                      updatedList[index] = item.copyWith(selected: value ?? false);
                                    });
                                  },
                                  value: item.selected,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(child: Text(item.name.capitalizeOnlyFirstLetter()))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 26.0),
                      ElevatedButton(
                        onPressed: () {
                          context.router.pop();
                          onConfirmed?.call(updatedList);
                        },
                        child: Text(
                          LocalizedTexts.continueBtn.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void filterDialogFavorites({
    required BuildContext context,
    required String title,
    required Widget listWidget,
    String? subtitle,
    VoidCallback? onConfirmed,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 40.0,
            right: 24.0,
            bottom: 40.0,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.router.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (subtitle != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Divider(height: 2, thickness: 2, color: AppColors.bgGreen),
                  listWidget,
                  const SizedBox(
                    height: 26.0,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onConfirmed,
                child: Text(
                  LocalizedTexts.continueBtn.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void surveyFinishedMessage({
    required BuildContext context,
    required void Function() onBtnPress,
  }) {
    showModalBottomSheet<void>(
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          height: 430,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 54.0),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: AppImages.like,
              ),
              const SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocalizedTexts.surveyFinishedBottomSheetTitle.tr(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.blueDark),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      LocalizedTexts.surveyFinishedBottomSheetMain.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 27.0),
              ElevatedButton(
                onPressed: onBtnPress,
                child: Text(LocalizedTexts.getStarted.translation),
              ),
            ],
          ),
        );
      },
    );
  }

  static void selectAMealDialog({
    required BuildContext context,
    required List<NameLabel> list,
    required List<String> filledList,
    required DateTime currentDate,
    required void Function(NameLabel item) onSelect,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 100,
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 40.0,
                right: 24.0,
                bottom: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.router.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    LocalizedTexts.selectAMeal.translation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: ThemeConstants.bitterFontFamily,
                          color: AppColors.blueDark,
                        ),
                  ),
                  Text(
                    currentDate.isSameDate(DateTime.now())
                        ? LocalizedTexts.today.translation
                        : currentDate.shortDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.blueDark,
                        ),
                  ),
                  const SizedBox(height: 24.0),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: AppColors.bgGreen,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = list[index];
                        final isFilled = filledList.contains(item.shortValue.toLowerCase());

                        return InkWell(
                          onTap: () {
                            context.router.pop();
                            onSelect(item);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: AppColors.bgGreen,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: ImageIcon(
                                    isFilled ? AppIcons.iconCheckmark : item.icon,
                                    color: isFilled ? AppColors.blueDark : AppColors.darkGreen,
                                  ),
                                ),
                                Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: isFilled ? AppColors.greyLabel : AppColors.darkGreen,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 56.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void readTextVersion({
    required BuildContext context,
    required void Function() onBtnPress,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<EducationLessonBloc, EducationLessonState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(backgroundColor: AppColors.white),
              body: SafeArea(
                child: ScrollableContainer(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipPath(
                            clipper: OvalBottomBorderClipper(),
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              color: AppColors.white,
                            ),
                          ),
                          Positioned(
                            bottom: -95,
                            left: 1,
                            right: 1,
                            child: SizedBox(
                              width: 234,
                              height: 182,
                              child: NetworkImageWithCache(url: state.data.lessonImage),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              state.data.lessonCategory.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.orangeDark, fontSize: 12.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              state.data.lessonTitle,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    fontFamily: ThemeConstants.bitterFontFamily,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          HtmlRenderer(content: state.data.currentPage.content.html),
                          const SizedBox(height: 24.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: ElevatedButton(
                              onPressed: onBtnPress,
                              child: Text(LocalizedTexts.next.translation),
                            ),
                          ),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void emergencyNumbers({
    required BuildContext context,
    required void Function() onBtnPress,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.93,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: IconButton(
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                        onPressed: () => context.router.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  Text(
                    LocalizedTexts.inCaseOfEmergency.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontFamily: ThemeConstants.bitterFontFamily),
                  ),
                  const SizedBox(height: 12),
                  Text(LocalizedTexts.emergencySubtitle.tr(), style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: emergencyNumbersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EmergencyNumberCard(
                          number: emergencyNumbersList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 2.0,
                          height: 2.0,
                          color: AppColors.bgGreen,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void leaveSessionCall({
    required BuildContext context,
    required void Function() onLeavePressed,
    required void Function() onStayPressed,
  }) {
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 42.0, horizontal: 39.0),
          height: size.height * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                LocalizedTexts.sessionLeaveDialogText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 48.0),
              ElevatedButton(
                onPressed: () {
                  context.router.pop();
                  onLeavePressed();
                },
                child: const Text(LocalizedTexts.leaveSession).tr(),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: onStayPressed,
                child: const Text(LocalizedTexts.stayInTheSession).tr(),
              )
            ],
          ),
        );
      },
    );
  }
}
