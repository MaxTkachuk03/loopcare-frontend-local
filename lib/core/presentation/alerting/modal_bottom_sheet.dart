import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_blue.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';

class ModalBottomSheet {
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
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20.0),
              Text(
                LocalizedTexts.emailConfirmedBottomSheetContent.tr(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: onContinuePressed,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.orangeDark),
                    ),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: AppColors.orangeDark),
                ),
              ),
              const SizedBox(height: 27.0),
              ElevatedButton(
                onPressed: onBtnPress,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.bgGreen),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.black),
                    ),
                child: Text(btnText),
              ),
            ],
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
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.consentConfirmationMoreInfoTextOne
                              .tr(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.consentConfirmationMoreInfoTextTwo
                              .tr(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          LocalizedTexts.downloadInstructionWhatToAsk.tr(),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
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

  static void nutrientFactsDialog({
    required BuildContext context,
    required List<dynamic> list,
    required void Function(dynamic item) onSelect,
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
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    LocalizedTexts.showNutritionValue.translation,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: AppColors.bgGreen,
                  ),
                  ...list.map(
                    (item) => InkWell(
                      onTap: () => onSelect(item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2, color: AppColors.bgGreen),
                          ),
                        ),
                        child: Text('Test'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 56.0,
                  ),
                ],
              ),
            ],
          ),
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
          builder:
              (BuildContext context, void Function(void Function()) setState) {
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
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Divider(
                          height: 2, thickness: 2, color: AppColors.bgGreen),
                      ...updatedList.map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 2, color: AppColors.bgGreen),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CheckboxBlue(
                                  onChanged: (bool? value) {
                                    final index = updatedList.indexOf(item);

                                    setState(() {
                                      updatedList[index] = item.copyWith(
                                          selected: value ?? false);
                                    });
                                  },
                                  value: item.selected,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(child: Text(item.name))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                    ],
                  ),
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
            );
          },
        );
      },
    );
  }

  static void filterDialogServings({
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Divider(
                      height: 2, thickness: 2, color: AppColors.bgGreen),
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
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: AppColors.blueDark),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      LocalizedTexts.surveyFinishedBottomSheetMain.tr(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 27.0),
              ElevatedButton(
                onPressed: onBtnPress,
                child: Text(btnText),
              ),
            ],
          ),
        );
      },
    );
  }
}
