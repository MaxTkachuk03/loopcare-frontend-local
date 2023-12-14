import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum CustomAppBarTextTheme { light, dark }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final CustomAppBarTextTheme? textTheme;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
    this.textTheme = CustomAppBarTextTheme.dark,
    this.subtitle,
    this.leading,
    this.actions,
    this.backgroundColor,
  });

  factory CustomAppBar.coral({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.coralRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.orange({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.orangeRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.yellow({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.yellowRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.green({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.greenRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.petrol({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        textTheme: CustomAppBarTextTheme.light,
        backgroundColor: AppColors.petrolRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.blue({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        textTheme: CustomAppBarTextTheme.light,
        backgroundColor: AppColors.blueRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.dark({
    required String title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        textTheme: CustomAppBarTextTheme.light,
        backgroundColor: AppColors.black,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  Color get _titleColor => textTheme == CustomAppBarTextTheme.dark ? AppColors.blueDarker : Colors.white;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _Title(title: title, subtitle: subtitle),
      titleTextStyle: AppBarTheme.of(context).titleTextStyle?.copyWith(color: _titleColor),
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: Padding(padding: const EdgeInsets.all(6.0), child: leading),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Title extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _Title({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, maxLines: 2),
        if (subtitle != null)
          Text(
            subtitle!,
            style: const TextStyle(fontSize: ThemeConstants.fontSize14, fontWeight: FontWeight.w400),
          ),
      ],
    );
  }
}
