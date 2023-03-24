import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/back_button_hexagon.dart';

class BlueAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final bool? isCustomLeading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Function()? onCustomTap;
  final Function()? onClose;

  const BlueAppBar({
    Key? key,
    this.title,
    this.subtitle,
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
    final title = widget.title;

    return AppBar(
      backgroundColor: AppColors.blueAppBar,
      title: (title != null)
          ? _Title(
              title: title,
              subtitle: widget.subtitle,
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

class _Title extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _Title({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subtitle != null) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
            children: <TextSpan>[
              TextSpan(
                text: '\n$subtitle',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ]),
      );
    }

    return Text(
      title,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
    );
  }
}
