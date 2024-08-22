part of '../river_animation_module_item_widget.dart';

class _RiverItemFootprint extends StatefulWidget {
  final RiverModuleItem item;
  final double radius;
  final bool isBeginning;

  const _RiverItemFootprint({
    super.key,
    required this.item,
    required this.radius,
    this.isBeginning = false,
  });

  @override
  State<_RiverItemFootprint> createState() => _RiverItemFootprintState();
}

class _RiverItemFootprintState extends State<_RiverItemFootprint>
    with TickerProviderStateMixin, RiverUtils {
  late AnimationController _controller;
  late AnimationController _theBeginningController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _foregroundColorAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  bool get isBeginning => widget.isBeginning;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _unlockDuration, vsync: this);
    _theBeginningController = AnimationController(duration: _unlockDuration, vsync: this);

    _backgroundColorAnimation = ColorTween(
      begin: getBackgroundColor(widget.item.states.itemState, widget.item.streamType),
      end: AppColors.red,
    ).animate(_controller);

    _foregroundColorAnimation = ColorTween(
      begin: getIconColor(widget.item.states.itemState, widget.item.streamType),
      end: AppColors.red,
    ).animate(_controller);

    _scaleAnimation = Tween<double>(
      begin: widget.radius,
      end: 4.0,
    ).animate(_controller);

    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 0.0,
    ).animate(_theBeginningController);

    if (!isBeginning) {
      _controller.forward();
    } else {
      _theBeginningController.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _theBeginningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RiverModuleItemPreview(
          item: widget.item,
          elevation: _elevationAnimation.value,
          radius: _scaleAnimation.value,
          backgroundColor: _backgroundColorAnimation.value,
          iconColor: _foregroundColorAnimation.value,
        );
      },
    );
  }
}
