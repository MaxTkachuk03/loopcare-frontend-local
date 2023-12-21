import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/app_unlock_block.dart';

class FoodLoggingUnlockBloc extends StatelessWidget {
  const FoodLoggingUnlockBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        AppUnlockBlock(
          title: LocalizedTexts.foodLoggingUnlocked.translation.capitalize(),
          text: LocalizedTexts.youCanStartLogging.translation.capitalize(),
        ),
      ],
    );
  }
}
