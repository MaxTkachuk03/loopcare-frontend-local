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

  const BlueAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.italicSubtitle,
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

    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return AppBar(
          backgroundColor: state.isPlanningMeals ? AppColors.darkGreen : AppColors.blueAppBar,
          title: (title != null)
              ? _Title(
                  title: title,
                  subtitle: widget.subtitle,
                  italicSubtitle: widget.italicSubtitle,
                )
              : null,
          leading: widget.isCustomLeading ?? false ? const BackButtonHexagon() : widget.leading,
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
    Key? key,
    required this.title,
    this.subtitle,
    this.italicSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontStyle: italicSubtitle ?? true ? FontStyle.italic : FontStyle.normal,
                ),
          ),
      ],
    );
  }
}
