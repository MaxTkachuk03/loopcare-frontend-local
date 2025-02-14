import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

import '../../../../../../localization/service/Localized_texts.dart';

class MeasuringParams extends StatefulWidget {
  final double weightDifference;
  final Color textColor;
  final String userWeightUnits;

  const MeasuringParams(
      {super.key,
      required this.weightDifference,
      required this.textColor,
      required this.userWeightUnits});

  @override
  State<MeasuringParams> createState() => _MeasuringParamsState();
}

class _MeasuringParamsState extends State<MeasuringParams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 18, left: 22, right: 22, bottom: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.w700(
            '${widget.weightDifference.toString()}${widget.userWeightUnits}',
            style: context.textTheme.titleLarge
                ?.copyWith(color: widget.textColor, fontSize: ThemeConstants.fontSize16),
          ),
          CustomText.w400(
            LocalizedTexts.weight.tr(),
            style: context.textTheme.bodyMedium
                ?.copyWith(color: AppColors.blueDarker, fontSize: ThemeConstants.fontSize12),
          ),
        ],
      ),
    );
  }
}
