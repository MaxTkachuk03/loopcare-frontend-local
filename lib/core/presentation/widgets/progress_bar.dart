import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class ProgressBar extends StatelessWidget {
  final int progress;
  final Color? backgroundColor;

  const ProgressBar({super.key, required this.progress, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.bgGreen,
      child: Center(
        child: SizedBox(
          width: 96.0,
          child: Row(
            children: [
              SizedBox(
                width: 16.0,
                height: 16.0,
                child: Hexagon(
                  width: 20.0,
                  height: 20.0,
                  borderRadius: 0,
                  innerWidget: Container(
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 4,
                      color: AppColors.yellowLight,
                    ),
                    SizedBox(
                      height: 4,
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            height: 4,
                            width: constraints.maxWidth * progress / 100,
                            color: AppColors.darkGreen,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: const ShapeDecoration(
                  shape: PolygonBorder(
                    sides: 6,
                    rotate: 30.0,
                    side: BorderSide(color: AppColors.yellowLight, width: 4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
