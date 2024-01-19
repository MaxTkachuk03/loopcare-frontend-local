import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class GroupedNotSigned extends StatelessWidget {
  final String topicName;

  const GroupedNotSigned({
    super.key,
    required this.topicName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomText.w600(
                topicName,
                style: context.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        CustomOutlinedButton.coralFullWidth(
          label: LocalizedTexts.bookYourSeatNow,
          onPressed: () => _onBookSeatPressed(context),
        ),
      ],
    );
  }

  _onBookSeatPressed(BuildContext context) {
    ModalBottomSheet.sessionsDialog(context: context);
  }
}
