import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class GreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  final Widget? leading;
  final List<Widget>? actions;
  final Function()? onCustomTap;
  final Function()? onClose;

  const GreenAppBar({
    Key? key,
    required this.text,
    this.leading,
    this.actions,
    this.onCustomTap,
    this.onClose,
  }) : super(key: key);

  @override
  State<GreenAppBar> createState() => _GreenAppBarState();

  @override
  Size get preferredSize => Size(56, AppBar().preferredSize.height);
}

class _GreenAppBarState extends State<GreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueDark,
      title: Text(
        widget.text,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
      ),
      leading: widget.leading,
      automaticallyImplyLeading: false,
      actions: widget.actions,
    );
  }
}
