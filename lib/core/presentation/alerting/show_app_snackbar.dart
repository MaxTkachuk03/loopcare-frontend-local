import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';

void showAppSnackBar({
  required BuildContext context,
  required String text,
  Color? background,
}) {
  final size = MediaQuery.of(context).size;

  showFlash(
    context: context,
    duration: const Duration(
      seconds: 5,
    ),
    builder: (context, FlashController controller) {
      return Flash(
        controller: controller,
        alignment: Alignment.topCenter,
        backgroundColor: background ?? AppColors.greenMid,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadows: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0.0, 0.0),
            blurRadius: 12,
          ),
        ],
        child: SizedBox(
          width: size.width * 0.8718,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      );
    },
  );
}
