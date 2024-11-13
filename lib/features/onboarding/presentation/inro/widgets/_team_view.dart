part of '../onboarding_intro_our_mission_page.dart';

class _TeamView extends StatefulWidget {
  const _TeamView({
    required this.controller,
  });

  final PageController controller;

  @override
  State<_TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<_TeamView> {
  final pageListener = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      pageListener.value = widget.controller.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    pageListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = constraints.maxWidth * 0.14;

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth * 0.9,
          child: Stack(
            children: [
              Positioned(
                top: constraints.maxWidth * 0.2,
                left: 0,
                right: 0,
                child: const Image(image: AppImages.onboardingIntro),
              ),
              ..._Member.values.map((member) => Positioned(
                    left: constraints.maxWidth * member.position.dx,
                    top: constraints.maxWidth * member.position.dy,
                    child: _TeamMemberAvatar(
                      onTap: () => widget.controller.jumpToPage(member.index),
                      radius: radius,
                      member: member,
                    ),
                  )),
              ValueListenableBuilder<int>(
                valueListenable: pageListener,
                builder: (context, value, _) {
                  final member = _Member.values[value];

                  final child = _PositionedArrow(
                    key: ValueKey(member),
                    maxWidth: constraints.maxWidth,
                    member: member,
                  );

                  return AnimatedFadeHolder.positioned(
                    child: child,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TeamMemberAvatar extends StatelessWidget {
  const _TeamMemberAvatar({
    required this.radius,
    required this.onTap,
    required this.member,
  });

  final double radius;
  final void Function() onTap;
  final _Member member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: member.color,
        child: CircleAvatar(
          radius: radius * 0.8,
          foregroundImage: member.image,
        ),
      ),
    );
  }
}

class _PositionedArrow extends StatelessWidget {
  const _PositionedArrow({
    required super.key,
    required this.member,
    required this.maxWidth,
  });

  final _Member member;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: maxWidth * member.arrowPosition.dx,
      top: maxWidth * member.arrowPosition.dy,
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ(member.arrowRotation)
          ..rotateY(member.mirrorArrowRotation),
        child: AppImages.onboardingArrow,
      ),
    );
  }
}
