import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w600(
          LocalizedTexts.noGroupThisWeek.tr(),
          style: context.textTheme.bodySmall,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
