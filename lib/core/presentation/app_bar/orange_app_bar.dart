import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class OrangeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const OrangeAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.orangeDark,
      title: (title != null)
          ? Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
            )
          : null,
      leading: const BackButtonHexagon(),
      automaticallyImplyLeading: false,
    );
  }
}
