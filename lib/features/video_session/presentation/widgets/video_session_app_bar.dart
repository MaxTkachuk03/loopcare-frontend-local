import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class VideoSessionAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;

  const VideoSessionAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.actions,
  }) : super(key: key);

  @override
  State<VideoSessionAppBar> createState() => _VideoSessionAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _VideoSessionAppBarState extends State<VideoSessionAppBar> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;

    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return AppBar(
          backgroundColor: AppColors.blueAppBar,
          title: _Title(
            title: title,
            subtitle: widget.subtitle,
          ),
          leading: const BackButtonHexagon(),
          automaticallyImplyLeading: false,
          actions: widget.actions,
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Title({
    Key? key,
    required this.title,
    required this.subtitle,
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
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
      ],
    );
  }
}
