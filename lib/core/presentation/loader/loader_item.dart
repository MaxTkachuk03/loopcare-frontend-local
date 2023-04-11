import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class LoaderItem extends StatefulWidget {
  final double _size = 25;
  final _sizeMultiplier = 1.2;
  final Duration _duration = const Duration(milliseconds: 400);
  final Color endColor;
  final Duration delayBeforeStart;

  const LoaderItem({
    super.key,
    required this.endColor,
    required this.delayBeforeStart,
  });

  @override
  _LoaderItemState createState() => _LoaderItemState();
}

class _LoaderItemState extends State<LoaderItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationSize;
  late Animation<Color?> _animationColor;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget._duration,
      vsync: this,
    );

    _animationSize = Tween<double>(
      begin: widget._size,
      end: widget._size * widget._sizeMultiplier,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _animationColor = ColorTween(
      begin: const Color(0xffDDD8C7),
      end: widget.endColor,
    ).animate(_controller);

    // Adding delay between animation repeat
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _timer = Timer(widget._duration, () {
          _controller.forward();
        });
      }
    });

    // Adding delay before animation starts
    Future.delayed(widget.delayBeforeStart, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: HexagonPainter(
            size: _animationSize.value,
            color: _animationColor.value,
          ),
          child: SizedBox(
            width: widget._size,
            height: widget._size,
          ),
        );
      },
    );
  }
}

class HexagonPainter extends CustomPainter {
  final double size;
  final Color? color;

  HexagonPainter({
    required this.size,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cornerRadius = this.size * 0.1;
    final double hexagonSize = this.size - cornerRadius * 2;
    final double hexagonRadius = hexagonSize / 2;

    final Path path = Path();

    path.moveTo(hexagonRadius + cornerRadius, 0);

    for (int i = 1; i <= 7; i++) {
      final double angle = 2.0 * math.pi / 6 * i;
      final double x = hexagonRadius + hexagonRadius * math.cos(angle);
      final double y = hexagonRadius + hexagonRadius * math.sin(angle);
      path.lineTo(x + cornerRadius * math.cos(angle - math.pi / 6),
          y + cornerRadius * math.sin(angle - math.pi / 6));
      path.lineTo(x + cornerRadius * math.cos(angle + math.pi / 6),
          y + cornerRadius * math.sin(angle + math.pi / 6));
    }

    path.close();

    final Paint paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
