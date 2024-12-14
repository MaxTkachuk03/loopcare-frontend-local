import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SummaryItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final String quantity;
  final String? quantityLabel;

  const SummaryItem({
    super.key,
    required this.label,
    required this.icon,
    required this.quantity,
    this.quantityLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w400(
          label,
          maxLines: 1,
          style: context.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            icon,
            const SizedBox(
              width: 6.0,
            ),
            RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: quantity,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (quantityLabel != null)
                    TextSpan(
                      text: ' $quantityLabel',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
