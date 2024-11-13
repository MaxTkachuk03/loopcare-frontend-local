part of '../animated_bottom_bar.dart';

class _CustomBottomNavigationBarItem extends StatelessWidget {
  const _CustomBottomNavigationBarItem({
    this.onTap,
    this.selected = false,
    this.showBadge = false,
    required this.animation,
    required this.label,
    required this.icon,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final String label;
  final Widget icon;
  final bool showBadge;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.blueLightest : AppColors.blueLighter;
    final textStyle = context.textTheme.labelMedium?.copyWith(color: color);

    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: animation,
        child: InkWell(
          radius: MediaQuery.of(context).size.width / 8 - 10,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Column(
            children: [
              const SizedBox(height: 12),
              badge.Badge(
                showBadge: showBadge,
                badgeStyle: const badge.BadgeStyle(badgeColor: AppColors.red),
                badgeAnimation: const badge.BadgeAnimation.fade(toAnimate: false),
                position: badge.BadgePosition.topEnd(top: -2, end: -2),
                child: icon,
              ),
              const SizedBox(height: 4),
              Flexible(
                child: CustomText.w400(
                  label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
