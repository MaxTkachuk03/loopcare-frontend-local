import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum CustomAppBarTextTheme { light, dark }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final CustomAppBarTextTheme? textTheme;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final GestureTapCallback? onTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
    this.textTheme = CustomAppBarTextTheme.dark,
    this.subtitle,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.bottom,
    this.onTap,
  });

  factory CustomAppBar.transparent({
    String? title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.transparent,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
      );

  factory CustomAppBar.coral({
    String? title,
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
    String? title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
    GestureTapCallback? onTap,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.orangeRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
        onTap: onTap,
      );

  factory CustomAppBar.yellow({
    String? title,
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
    String? title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) =>
      CustomAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        textTheme: CustomAppBarTextTheme.dark,
        backgroundColor: AppColors.greenRegular,
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
        bottom: bottom,
      );

  factory CustomAppBar.petrol({
    String? title,
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
    String? title,
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
    String? title,
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
      title: _Title(title: title, subtitle: subtitle, onTap: onTap),
      titleTextStyle: AppBarTheme.of(context).titleTextStyle?.copyWith(color: _titleColor),
      backgroundColor: backgroundColor,
      forceMaterialTransparency: backgroundColor == AppColors.transparent,
      automaticallyImplyLeading: false,
      leading: Padding(padding: const EdgeInsets.all(6.0), child: leading ?? const BackButton()),
      actions: actions,
      bottom: bottom,
    );
  }

  double get getBottomPreferredSize => bottom?.preferredSize.height ?? 0;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + getBottomPreferredSize);
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final GestureTapCallback? onTap;

  const _Title({required this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? '',
          maxLines: 2,
        ),
        if (subtitle != null)
          InkWell(
            onTap: onTap,
            highlightColor: AppColors.transparent,
            child: Text(
              subtitle!,
              style: const TextStyle(fontSize: ThemeConstants.fontSize14, fontWeight: FontWeight.w400),
            ),
          ),
      ],
    );
  }
}
