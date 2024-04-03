import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class GroupSessionVideoError extends StatelessWidget {
  final String? errorMessage;
  final double width;
  final double height;
  final void Function() onUpdate;
  final void Function() onClose;

  const GroupSessionVideoError({
    super.key,
    this.errorMessage,
    required this.width,
    required this.height,
    required this.onUpdate,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, color: AppColors.white),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: onUpdate,
                  child: CustomText.w400(
                    LocalizedTexts.retry.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: onClose,
                  child: CustomText.w400(
                    LocalizedTexts.close.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
