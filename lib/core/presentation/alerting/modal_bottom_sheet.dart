import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ModalBottomSheet {
  ModalBottomSheet();

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
}
