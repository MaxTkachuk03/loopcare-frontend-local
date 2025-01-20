import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/small_card/small_card_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SmallCard extends StatelessWidget {
  final String url;
  final String text;
  final bool isCompleted;
  final String status;
  final void Function()? onPressed;

  const SmallCard({
    super.key,
    required this.url,
    required this.text,
    required this.isCompleted,
    required this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool checking = status.contains("null") && isCompleted == false;
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: checking ? Border.all(color: AppColors.greyLight) : null,
        borderRadius: checking ? BorderRadius.circular(10.0) : null,
        boxShadow: checking
            ? []
            : [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black.withOpacity(0.05)),
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                    color: AppColors.black.withOpacity(0.05))
              ],
      ),
      child: checking
          ? SmallCardItem(
              url: url,
              text: text,
              checking: checking,
              isCompleted: isCompleted,
            )
          : Card(
              color: AppColors.white,
              child: SmallCardItem(
                url: url,
                text: text,
                checking: checking,
                isCompleted: isCompleted,
                onPressed: onPressed,
              ),
            ),
    );
  }
}
