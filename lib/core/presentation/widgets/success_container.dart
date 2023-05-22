import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SuccessContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final EdgeInsetsGeometry? contentPadding;

  const SuccessContainer({
    Key? key,
    required this.title,
    required this.content,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.greenLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 39,
                          bottom: 25,
                          left: 44,
                          right: 44,
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontFamily: ThemeConstants.bitterFontFamily,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: AppImages.checkMarkGreen,
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: contentPadding ??
              const EdgeInsets.only(
                top: 48,
                bottom: 34,
                left: 34,
                right: 34,
              ),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )),
          child: content,
        ),
      ],
    );
  }
}
