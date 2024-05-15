part of '../mind_video_screen.dart';

class _OrientationStateVideoWrapper extends StatelessWidget {
  const _OrientationStateVideoWrapper({
    super.key,
    required this.orientationsState,
    required this.screenSize,
    required this.child,
  });

  final _OrientationsState orientationsState;
  final Size screenSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (orientationsState.isNotMixed) {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox.fromSize(
          size: screenSize,
          child: child,
        ),
      );
    } else {
      return Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: kToolbarHeight),
              child: RotateDeviceMessage(),
            ),
          ),
          child,
          const Spacer(),
        ],
      );
    }
  }
}
