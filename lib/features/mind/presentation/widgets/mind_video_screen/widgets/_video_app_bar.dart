part of '../mind_video_screen.dart';

class _VideoAppBar extends StatelessWidget {
  const _VideoAppBar({
    super.key,
    required this.topPadding,
    required this.title,
  });

  final String title;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, topPadding, 12.0, 0.0),
      color: Colors.black45,
      child: Row(
        children: [
          CustomFilledIconButton.fromColor(color: Colors.white54),
          Expanded(
            child: CustomText(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 44)
        ],
      ),
    );
  }
}
