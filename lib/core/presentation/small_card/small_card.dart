import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/small_card/small_card_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SmallCard extends StatelessWidget {
  final String url;
  final String text;
  final bool isCompleted;
  final String status;

  const SmallCard({
    super.key,
    required this.url,
    required this.text,
    required this.isCompleted,
    required this.status,
  });

  static const double iconSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border:
            status.isNotEmpty ? null : Border.all(color: AppColors.greyLight),
        borderRadius: status.isNotEmpty ? null : BorderRadius.circular(10.0),
        boxShadow: status.isNotEmpty
            ? [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black.withOpacity(0.05)),
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                    color: AppColors.black.withOpacity(0.05))
              ]
            : [],
      ),
      child: status.isNotEmpty
          ? Card(
              color: status.isNotEmpty ? null : AppColors.white,
              child: SmallCardItem(
                url: url,
                iconSize: iconSize,
                text: text,
                status: status,
                isCompleted: isCompleted,
              ),
            )
          : SmallCardItem(
              url: url,
              iconSize: iconSize,
              text: text,
              status: status,
              isCompleted: isCompleted,
            ),
    );
  }
}
