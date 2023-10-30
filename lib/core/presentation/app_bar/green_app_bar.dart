import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class GreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool darkGreen;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const GreenAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.darkGreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkGreen ? AppColors.darkGreen : AppColors.greenMid,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: darkGreen ? FontWeight.w400 : FontWeight.w600,
                        color: AppColors.white,
                      ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: darkGreen ? FontWeight.w400 : FontWeight.w600,
                          color: AppColors.white,
                        ),
                  ),
              ],
            ),
          ),
          if (darkGreen)
            IconButton(
              onPressed: () => {
                context.router.pop(),
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.white,
              ),
            )
        ],
      ),
      leading: darkGreen ? null : const BackButtonHexagon(),
      automaticallyImplyLeading: false,
    );
  }
}
