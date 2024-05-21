import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class BlueAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool? italicSubtitle;
  final Widget? leading;
  final bool? isCustomLeading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Function()? onCustomTap;
  final Function()? onClose;
  final bool isPlanningMeals;

  const BlueAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.italicSubtitle,
    this.leading,
    this.isCustomLeading,
    this.bottom,
    this.actions,
    this.onCustomTap,
    this.onClose,
    this.isPlanningMeals = false,
  });

  @override
  State<BlueAppBar> createState() => _BlueAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BlueAppBarState extends State<BlueAppBar> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;

    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return AppBar(
          backgroundColor: AppColors.blueAppBar,
          centerTitle: true,
          titleSpacing: 16,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.isCustomLeading ?? false)
                const BackButtonHexagon()
              else
                widget.leading ??
                    const SizedBox(
                      width: 44,
                    ),
              (title != null)
                  ? Expanded(
                      child: _Title(
                        title: title,
                        subtitle: widget.subtitle,
                        italicSubtitle: widget.italicSubtitle,
                      ),
                    )
                  : const SizedBox.shrink(),
              if (widget.actions == null)
                const SizedBox(
                  width: 44,
                ),
            ],
          ),
          bottom: widget.bottom,
          automaticallyImplyLeading: false,
          actions: widget.actions,
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool? italicSubtitle;

  const _Title({
    required this.title,
    this.subtitle,
    this.italicSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
        ),
        if (subtitle != null && (subtitle?.isNotEmpty ?? false))
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontStyle: italicSubtitle ?? true ? FontStyle.italic : FontStyle.normal,
                ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
