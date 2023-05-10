import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SummaryItem extends StatelessWidget {
  final String label;
  final SvgPicture icon;
  final String quantity;
  final String? quantityLabel;

  const SummaryItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.quantity,
    this.quantityLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.greyLabel),
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: quantity,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (quantityLabel != null)
                    TextSpan(
                      text: ' $quantityLabel',
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
