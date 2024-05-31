import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_numbers.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/widgets/already_planned_card.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/emergency_numbers/emergency_number_card.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_chat_report.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/booked_session_modal_content.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/not_booked_sessions_modal_content.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/widget/report_abuse_widget.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class ModalBottomSheet {
  ModalBottomSheet._();

  static void emailConfirmed({
    required BuildContext context,
    required void Function() onContinuePressed,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      builder: (context) {
        return MainContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              const CircleAvatar(
                radius: 22.0,
                backgroundColor: AppColors.greenRegular,
                child: Icon(Icons.check, size: 30),
              ),
              const SizedBox(height: 26.0),
              CustomText.w600(
                '${LocalizedTexts.emailConfirmedBottomSheetTitle.tr()}!',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20.0),
              CustomText.w400(
                '${LocalizedTexts.emailConfirmedBottomSheetContent.tr()}.',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 40.0),
              CustomElevatedButton.blueFullWidth(
                label: LocalizedTexts.continueBtn.tr(),
                onPressed: context.router.pop,
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        );
      },
    ).whenComplete(onContinuePressed);
  }

  static void physicalInvalidMessage({required BuildContext context, required String message}) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32.0),
              CustomText.w500(
                message,
                style: context.textTheme.bodyMedium?.copyWith(color: AppColors.orangeDark),
              ),
              CustomText.w400(
                LocalizedTexts.correctHeight.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32.0),
              CustomElevatedButton.blueFullWidth(
                onPressed: context.router.pop,
                label: LocalizedTexts.changeYourHeight.tr(),
              ),
            ],
          ),
        );
      },
    );
  }

  static void restoreSubscription({
    required BuildContext context,
    required void Function() onSubscriptionPref,
    bool isDuplicate = false,
    required ValueNotifier<bool> sheetNotifier,
  }) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText.w400(
                    isDuplicate
                        ? '${LocalizedTexts.duplicateSubscriptionFromSettings.tr()}.'
                        : '${LocalizedTexts.restoreSubscriptionFromSettings.tr()}.',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32.0),
                  CustomElevatedButton.blueFullWidth(
                    onPressed: context.router.pop,
                    label: LocalizedTexts.cancel.tr(),
                  ),
                  const SizedBox(height: 12.0),
                  CustomOutlinedButton.blueFullWidth(
                    onPressed: onSubscriptionPref,
                    label: LocalizedTexts.manageSubscription.tr(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      sheetNotifier.value = false;
    });
  }

  static void deleteAccount({
    required BuildContext context,
    required bool noActiveSubscription,
    required void Function() onDeleted,
    required void Function() onSubscriptionPref,
  }) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText.w400(
                    noActiveSubscription
                        ? '${LocalizedTexts.deleteModalMessage.tr()}.'
                        : '${LocalizedTexts.cancelAccountSubscription.tr()}.',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32.0),
                  CustomElevatedButton.blueFullWidth(
                    onPressed: () {
                      //12.02.2024 Discussed with Diana
                      AnalyticsEventService.instance.logEvent(
                        FirebaseEvents.deleteAccount,
                        parameters: {
                          CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                          CustomDefinitions.confirmed: false,
                        },
                      );

                      context.router.pop();
                    },
                    label: LocalizedTexts.cancel.tr(),
                  ),
                  const SizedBox(height: 12.0),
                  CustomOutlinedButton.blueFullWidth(
                    onPressed: noActiveSubscription ? onDeleted : onSubscriptionPref,
                    label: noActiveSubscription
                        ? LocalizedTexts.yesDelete.tr()
                        : LocalizedTexts.manageSubscription.tr(),
                  )
                ],
              ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20.0, 38.0, 20.0, 30.0),
          child: CustomSafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomText.w600(
                    LocalizedTexts.youExceededTimeMessage.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.orangeRegular),
                  ),
                ),
                const SizedBox(height: 26.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomText.w400(
                    LocalizedTexts.noWorriesYouCanDoItLater.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 40.0),
                CustomElevatedButton.blueFullWidth(
                  onPressed: onStartAgain,
                  label: LocalizedTexts.startAgain.tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void deleteMultiDateMeal({
    required BuildContext context,
    required void Function() onDeleted,
    required void Function() onCanceled,
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
          child: CustomSafeArea(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32.0),
                            Text(
                              LocalizedTexts.deleteMultiDateMealModalMessage.tr(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ).tr(namedArgs: {
                              'mealCategory': mealCategory,
                            }),
                            const SizedBox(height: 8.0),
                            Text(
                              LocalizedTexts.deleteMultiDateMealModalExplain.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColors.darkGreen,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    LocalizedTexts.deleteMultiDateMealModalExplain2.tr(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 47.0),
                          ],
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: onCanceled,
                              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        width: 1.0,
                                        color: AppColors.blueDark,
                                      ),
                                    ),
                                  ),
                              child: Text(
                                LocalizedTexts.openDatepicker.tr(),
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
                              child: Text('${LocalizedTexts.remove.tr()} $mealCategory'),
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
          child: CustomSafeArea(
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
                              LocalizedTexts.deleteMealModalMessage.tr(),
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
                                LocalizedTexts.noCancel.tr(),
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
                              child: Text('${LocalizedTexts.remove.tr()} $mealCategory'),
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

  static void mentalHealthMoreInfo({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      builder: (BuildContext context) {
        return CustomSafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomIconButton.close(
                    onPressed: () => context.router.pop(),
                  ),
                ),
                MainContainer(
                  child: TextWithAccents(
                    LocalizedTexts.mentalHealthMoreInfo.tr(
                      namedArgs: {'appName': appConfig.projectName},
                    ),
                    accents: [
                      LocalizedTexts.mentalHealthMoreInfoBold1.tr(),
                      LocalizedTexts.mentalHealthMoreInfoBold2.tr(),
                    ],
                  ),
                ),
              ],
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
          child: CustomSafeArea(
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
                        LocalizedTexts.showNutritionValue.tr(),
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
              child: CustomSafeArea(
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
                      CustomText.bitter500(
                        state.data.weekTopicName,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 12.0),
                      const Divider(
                        thickness: 1.0,
                        height: 1.0,
                        color: AppColors.greyDarker,
                      ),
                      const SizedBox(height: 12.0),
                      state.data.isSigned && state.data.isGroupsOnWeekAvailable
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
                      CustomText.w700(
                        title,
                        style: context.textTheme.bodyMedium,
                      ),
                      if (subtitle != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 14.0),
                            CustomText.w400(
                              subtitle,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8.0),
                      ...updatedList.map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 32.0,
                                width: 32.0,
                                child: CustomCheckbox.blue(
                                  onChanged: (bool? value) {
                                    final index = updatedList.indexOf(item);

                                    setState(
                                      () {
                                        updatedList[index] = item.copyWith(selected: value ?? false);
                                      },
                                    );
                                  },
                                  value: item.selected,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: CustomText.w400(
                                  item.name.capitalizeOnlyFirstLetter(),
                                  style: context.textTheme.bodyMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 26.0),
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () {
                          context.router.pop();
                          onConfirmed?.call(updatedList);
                        },
                        label: LocalizedTexts.continueBtn.tr(),
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
    String? serving,
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
                      child: CustomIconButton.close(
                        onPressed: () => context.router.pop(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  CustomText.w700(
                    title,
                    style: context.textTheme.bodyMedium,
                  ),
                  if (subtitle != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 9.0),
                        CustomText.bitter600(
                          subtitle,
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                  if (serving != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 9.0),
                        CustomText.w400(
                          serving,
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                  const SizedBox(height: 24.0),
                  const Divider(height: 2, thickness: 2, color: AppColors.bgGreen),
                  listWidget,
                  const SizedBox(height: 26.0),
                ],
              ),
              CustomElevatedButton.blueFullWidth(
                onPressed: onConfirmed,
                label: LocalizedTexts.confirm.tr(),
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
      backgroundColor: AppColors.greenOffRegular,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.45,
          child: CustomSafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 24.0,
                right: 24.0,
                bottom: 20.0,
              ),
              child: CustomRoundedContainer(
                bgColor: AppColors.greenLightest,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 16.0,
                        height: 16.0,
                        child: CustomIconButton.close(
                          onPressed: () => context.router.pop(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.iWantToLogMy.tr()}...',
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 24.0),
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
                            child: Row(
                              children: [
                                IconButton(
                                  icon: isFilled ? AppIcons.checkmarkSVG : item.icon ?? AppIcons.checkmarkSVG,
                                  color: isFilled ? AppColors.blueDarker : AppColors.darkGreen,
                                  onPressed: () => {},
                                  iconSize: 14.0,
                                ),
                                Expanded(
                                  child: CustomText.w500(
                                    item.name,
                                    style: context.textTheme.titleSmall?.copyWith(
                                      color: isFilled ? AppColors.blueDarker : AppColors.darkGreen,
                                    ),
                                  ),
                                ),
                                const ImageIcon(
                                  AppIcons.arrow,
                                  color: AppColors.blueDarker,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
    required void Function() onCompleteModal,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          child: BlocBuilder<EducationLessonBloc, EducationLessonState>(
            builder: (context, state) {
              return ScrollableContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: 234,
                      height: 182,
                      child: NetworkImageWithCache(url: state.data.lessonImage),
                    ),
                    const SizedBox(height: 28.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainContainer(child: getLabelByCategory(state.data.lessonCategory)),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: CustomText.bitter600(
                            state.data.lessonTitle,
                            style: context.textTheme.displayLarge,
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        HtmlRenderer(content: state.data.currentPage.content.html),
                        const SizedBox(height: 18.0),
                        MainContainer(
                          child: CustomElevatedButton.blueFullWidth(
                            onPressed: () {
                              context.router.pop();
                              onBtnPress();
                            },
                            label: LocalizedTexts.next.tr(),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).whenComplete(onCompleteModal);
  }

  static void reportAbuse({
    required BuildContext context,
    GroupSessionReport? groupSession,
    GroupChatReport? chatReport,
  }) =>
      showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          barrierColor: AppColors.blueDarkest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.93,
              child: KeyboardContainerListener(
                child: CustomSafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: ReportAbuseWidget(
                      groupSession: groupSession,
                      chatReport: chatReport,
                      close: () => context.router.pop(),
                    ),
                  ),
                ),
              ),
            );
          });

  static void emergencyNumbers({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText.bitter500(
                    LocalizedTexts.inCaseOfEmergency.tr(),
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 12),
                  CustomText.w400(LocalizedTexts.emergencySubtitle.tr(), style: context.textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: emergencyNumbersList.length,
                    itemBuilder: (context, index) => EmergencyNumberCard(number: emergencyNumbersList[index]),
                    separatorBuilder: (_, __) {
                      return const Divider(thickness: 1.0, height: 1.0, color: AppColors.greyRegular);
                    },
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
          height: size.height * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppIcons.orangeExclamationMark,
              const SizedBox(height: 16.0),
              CustomText.w400(
                LocalizedTexts.sessionLeaveDialogText.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 48.0),
              CustomElevatedButton.blueFullWidth(
                onPressed: () {
                  context.router.pop();
                  onLeavePressed();
                },
                label: LocalizedTexts.leaveSession.tr(),
              ),
              const SizedBox(height: 12.0),
              CustomElevatedButton.blueFullWidth(
                onPressed: onStayPressed,
                label: LocalizedTexts.stayInTheSession.tr(),
              )
            ],
          ),
        );
      },
    );
  }

  static void replacePlannedMeal({
    required BuildContext context,
    required String date,
    required String mealCategory,
    required void Function() onBtnPressed,
    required void Function() onClose,
    required MealsListItem oldItem,
    required MealsListItem? newItem,
  }) {
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 42.0, horizontal: 39.0),
          height: size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      onPressed: () {
                        onClose();
                        context.router.pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              Text(
                date,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.blueDark,
                      fontWeight: FontWeight.w600,
                    ),
              ).tr(),
              const SizedBox(height: 16.0),
              Text(
                LocalizedTexts.youAlreadyPlanned.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ).tr(
                namedArgs: {'mealCategory': mealCategory},
              ),
              const SizedBox(height: 16.0),
              AlreadyPlannedCard(
                mealCategory: mealCategory,
                mealItems: oldItem.mealItems,
                active: false,
              ),
              const SizedBox(height: 24.0),
              Text(
                LocalizedTexts.replaceWith.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.blueDark,
                    ),
              ).tr(),
              if (newItem != null) const SizedBox(height: 16.0),
              if (newItem != null)
                AlreadyPlannedCard(
                  mealCategory: mealCategory,
                  mealItems: newItem.mealItems,
                  active: true,
                ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  onBtnPressed();
                },
                child: const Text(LocalizedTexts.yesReplace).tr(),
              ),
            ],
          ),
        );
      },
    );
  }

  static void appUpdate({
    required BuildContext context,
    required Future<void> Function()? onUpdatePressed,
  }) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return MainContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: AppColors.coralRegular),
                const SizedBox(height: 24),
                CustomText.w600(
                  LocalizedTexts.updateRequired.tr(),
                  style: context.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                CustomText.w400(
                  LocalizedTexts.updateRequiredBodyText1.tr(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                CustomText.w400(
                  LocalizedTexts.updateRequiredBodyText2.tr(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomElevatedButton.blueFullWidth(
                  label: LocalizedTexts.update.tr(),
                  onPressed: onUpdatePressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void inviteNewBuddy({
    required BuildContext context,
    required void Function() onInvite,
  }) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.w600(
                    LocalizedTexts.buddyFindAnotherBuddyLabel.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.orangeRegular),
                  ),
                  CustomText.w400(
                    LocalizedTexts.buddyFindAnotherBuddyContent.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12.0),
                  CustomElevatedButton.blueFullWidth(
                    onPressed: () {
                      context.router.pop.call();
                      onInvite.call();
                    },
                    label: LocalizedTexts.buddyFindAnotherBuddy.tr(),
                  ),
                  const SizedBox(height: 12.0),
                  CustomOutlinedButton.blueFullWidth(
                    onPressed: () => context.router.pop.call(),
                    label: LocalizedTexts.buddyNotNeedAnotherBuddy.tr(),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void goalFunFact({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String task,
    required String content,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppColors.greenLightest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      builder: (BuildContext context) {
        return MainContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 44.0,
                width: 44,
                child: AppIcons.lightbulbUnSelect,
              ),
              const SizedBox(height: 20.0),
              CustomText.bitter600(
                title,
                style: context.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              CustomText.w600(
                subtitle,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              CustomText.w400(
                task,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              CustomText.w400(
                content,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              CustomElevatedButton.blueFullWidth(
                label: LocalizedTexts.ok.tr().toUpperCase(),
                onPressed: context.router.pop,
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        );
      },
    );
  }

  static void smartGoalComplete({
    required BuildContext context,
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      builder: (BuildContext context) {
        return SingleChildScrollView(child: MainContainer(child: content));
      },
    );
  }

  static void nutritionIndicatorOverlay({
    required BuildContext context,
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      builder: (BuildContext context) {
        return FractionallySizedBox(
            heightFactor: 0.95, child: ScrollableContainer(child: MainContainer(child: content)));
      },
    );
  }
}
