import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WavyProgressContainer extends StatefulWidget {
  final double progress;
  const WavyProgressContainer({super.key, required this.progress});

  @override
  State<WavyProgressContainer> createState() => _WavyProgressContainerState();
}

class _WavyProgressContainerState extends State<WavyProgressContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Initialize the progress animation with the value from the widget
    _progressAnimation = Tween<double>(
      begin: widget.progress - 0.15,
      end: widget.progress,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant WavyProgressContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      // Update the animation controller's progress when the progress changes
      _progressAnimation = Tween<double>(
        begin: widget.progress - 0.15,
        end: widget.progress,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOutCubic,
          reverseCurve: Curves.easeInOutCubic,
        ),
      );
      _animationController.forward(from: 0.0); // Restart the animation
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 290,
      decoration: BoxDecoration(
          color: const Color(0xff245284),
          border: Border.all(color: const Color(0xff245284), width: 3)),
      child: Center(
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            double progress = _progressAnimation.value;
            return Stack(
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomPaint(
                        painter: WavyPainter(progress: progress),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WavyPainter extends CustomPainter {
  final double progress;
  WavyPainter({required this.progress});

  final List<Color> baseColors = [
    const Color(0xff4673A3),
    const Color(0xff3C6897),
    const Color(0xff245284),
    const Color(0xff1D4978),
    const Color(0xff163F6C),
    const Color(0xff10355F),
    const Color(0xff163F6C),
    const Color(0xff245284),
    const Color(0xff1D4978),
    const Color(0xff163F6C),
  ];

  final List<Color> progressColors = [
    const Color(0xffFFCC58),
    const Color(0xffF1BD45),
    const Color(0xffE87F34),
    const Color(0xffFD9447),
    const Color(0xffFF7E78),
    const Color(0xffEE6B65),
    const Color(0xff2B7B87),
    const Color(0xff3C9AA8),
    const Color(0xff93B23C),
    const Color(0xffAECA5F),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    double totalHeight = size.height + 3;
    double waveHeight = totalHeight / (baseColors.length - 3.1);
    double verticalOffset = -size.height * 0.1;

    double startY = verticalOffset + waveHeight;
    double lastWaveOffset = 40.0;

    for (int i = 0; i < baseColors.length; i++) {
      final Paint basePaint = Paint()
        ..color = baseColors[i]
        ..style = PaintingStyle.fill;

      final Paint progressPaint = Paint()..style = PaintingStyle.fill;

      final Path path = Path();

      double waveAmplitude = waveHeight * 2.5;
      if (i == baseColors.length - 10 || i == baseColors.length - 9) {
        waveAmplitude = waveHeight * 5.4;
      }
      if (i == baseColors.length - 8 || i == baseColors.length - 7) {
        waveAmplitude = waveHeight * 5.4;
      }
      if (i == baseColors.length - 6 || i == baseColors.length - 5) {
        waveAmplitude = waveHeight * 4.5;
      }
      if (i == baseColors.length - 4 || i == baseColors.length - 3) {
        waveAmplitude = waveHeight * 3.5;
      }
      if (i == baseColors.length - 2 || i == baseColors.length - 1) {
        waveAmplitude = waveHeight;
      }

      double controlPointX = size.width * 0.5;
      double controlPointY = startY + waveHeight * i - waveAmplitude;

      if (i > 5) {
        controlPointY = startY + waveHeight * i - waveAmplitude * 1.5;
      }

      if (i == baseColors.length - 1 || i == baseColors.length - 2) {
        controlPointY -= lastWaveOffset * 0.5;
      }

      path.moveTo(0, startY + waveHeight * i);

      path.quadraticBezierTo(
        controlPointX,
        controlPointY,
        size.width,
        startY + waveHeight * i,
      );

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      if (progress < 1) {
        canvas.drawPath(path, basePaint);
      }

      double progressWidth = size.width * progress;
      final Rect progressRect = Rect.fromLTWH(0, 0, progressWidth, size.height);

      if (progress >= 1) {
        progressPaint.color = progressColors[i % progressColors.length];
      } else {
        final Gradient progressGradient = LinearGradient(
          colors: [
            progressColors[i % progressColors.length],
            baseColors[i],
          ],
          stops: const [0.0, 1.0],
        );

        progressPaint.shader = progressGradient.createShader(progressRect);
      }

      canvas.save();
      canvas.clipRect(progressRect);
      canvas.drawPath(path, progressPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
