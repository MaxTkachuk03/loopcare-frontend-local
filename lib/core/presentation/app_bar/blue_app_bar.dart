import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/back_button_hexagon.dart';

class BlueAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? text;
  final Widget? leading;
  final bool? isCustomLeading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Function()? onCustomTap;
  final Function()? onClose;

  const BlueAppBar({
    Key? key,
    this.text,
    this.leading,
    this.isCustomLeading,
    this.bottom,
    this.actions,
    this.onCustomTap,
    this.onClose,
  }) : super(key: key);

  @override
  State<BlueAppBar> createState() => _BlueAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BlueAppBarState extends State<BlueAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.ballBlue,
      title: (widget.text != null)
          ? Text(
              widget.text ?? "",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
            )
          : null,
      leading: widget.isCustomLeading ?? false
          ? const BackButtonHexagon()
          : widget.leading,
      bottom: widget.bottom,
      automaticallyImplyLeading: false,
      actions: widget.actions,
    );
  }
}
