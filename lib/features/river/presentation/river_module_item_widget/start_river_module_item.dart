import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';

const _borderRadius = BorderRadius.all(Radius.circular(kRiverRootItemRadius));

class StartRiverModuleItem extends StatelessWidget {
  const StartRiverModuleItem({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: _borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: _borderRadius,
        child: CircleAvatar(
          radius: kRiverRootItemRadius,
          backgroundColor: AppColors.blueRegular,
          child: CustomText.w400(
            LocalizedTexts.start.tr(),
            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
