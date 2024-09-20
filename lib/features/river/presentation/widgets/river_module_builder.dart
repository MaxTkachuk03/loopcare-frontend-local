import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/animated_river_streams.dart';

const kDefaultModuleHeight = 240.0;

class RiverModuleBuilder extends StatelessWidget with RiverUtils {
  const RiverModuleBuilder({
    super.key,
    required this.index,
    required this.title,
    required this.totalDelay,
    required this.isCompleted,
    required this.completedDate,
    required this.positionedItems,
    required this.itemBuilder,
    this.isOverview = false,
    this.enableGradient,
    this.onCompleted,
    this.direction = Axis.vertical,
    this.topOffset = 0,
    this.dimension = kDefaultModuleHeight,
  });

  final int index;
  final Axis direction;
  final double topOffset;
  final double dimension;
  final String title;
  final DateTime? completedDate;
  final int totalDelay;
  final bool isCompleted;
  final bool isOverview;
  final bool? enableGradient;
  final void Function()? onCompleted;
  final Widget Function(BuildContext context, RiverModuleItem item) itemBuilder;
  final List<({Offset offset, RiverModuleItem item})> positionedItems;

  @override
  bool get isBeginning => index == 0;

  bool get _isVertical => direction == Axis.vertical;

  double get _angle => _isVertical ? math.pi / 2 : 0.0;

  double _itemTopPosition(Offset offset, double radius) =>
      _isVertical ? dimension * offset.dx - radius : topOffset + dimension * offset.dy - radius;

  double _itemLeftPosition(Offset offset, double radius) =>
      _isVertical ? dimension * (1 - offset.dy) - radius : dimension * offset.dx - radius;

  double? get _titleRightPosition => _isVertical ? 20.0 : null;

  double? get _titleWidth => _isVertical ? 106.0 : null;

  @override
  Widget build(BuildContext context) {
    final positionedModuleItems = List.generate(
      positionedItems.length,
      (index) {
        final offset = positionedItems[index].offset;
        final item = positionedItems[index].item;
        final radius = itemRadius(isRoot: item.isRootItem, isOverview: isOverview);

        return Positioned(
          top: _itemTopPosition(offset, radius),
          left: _itemLeftPosition(offset, radius),
          child: itemBuilder(context, item),
        );
      },
    );

    final TextStyle? titleStyle = _isVertical
        ? context.textTheme.bodyLarge?.copyWith(height: 1.1)
        : context.textTheme.displayLarge;

    final TextAlign titleAlign = _isVertical ? TextAlign.right : TextAlign.center;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: topOffset,
          left: 0,
          height: dimension,
          width: dimension,
          child: Transform.rotate(
            angle: _angle,
            child: AnimatedRiverStreams(
              page: index,
              enableGradient: enableGradient,
              driving: !isOverview,
              completedDate: completedDate,
              totalDelay: totalDelay,
              isCompleted: isCompleted,
              onCompleted: onCompleted,
            ),
          ),
        ),
        ...positionedModuleItems,
        Positioned(
          top: 20.0,
          right: _titleRightPosition,
          width: _titleWidth,
          child: CustomText.bitter600(
            title,
            style: titleStyle,
            textAlign: titleAlign,
          ),
        ),
      ],
    );
  }
}
