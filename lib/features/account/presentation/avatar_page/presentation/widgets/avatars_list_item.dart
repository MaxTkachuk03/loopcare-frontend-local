import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';

class AvatarsListItem extends StatelessWidget {
  final AvatarOption item;
  final bool isSelected;
  final Function(AvatarOption item) onPressed;

  const AvatarsListItem({
    super.key,
    required this.item,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(item),
      child: Column(
        children: [
          CircleAvatar(radius: 22, child: item.image),
          const SizedBox(height: 12),
          CustomText(
            item.label.capitalize(),
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
