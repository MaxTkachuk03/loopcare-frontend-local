import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';

import '../themes/themes.dart';

void showSuccessPopup({
  required BuildContext context,
  required String text,
}) async {
  await showFlash(
    context: context,
    duration: const Duration(
      seconds: 3,
    ),
    builder: (context, FlashController controller) {
      return Flash(
        controller: controller,
        alignment: Alignment.topCenter,
        backgroundColor: AppColors.white,
        boxShadows: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0.0, 0.0),
            blurRadius: 12,
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Image(image: AppIcons.hexaDone),
              const SizedBox(width: 16.0),
              Expanded(child: Text(text)),
            ],
          ),
        ),
      );
    },
  );
}
