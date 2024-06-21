import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/completed_module_item_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/locked_module_item_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/read_module_item_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/unlocked_module_item_widget.dart';

class GenericModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final Offset offset;
  final Function()? onTap;

  const GenericModuleItemWidget({
    super.key,
    required this.item,
    this.offset = Offset.zero,
    this.onTap,
  });

  @override
  State<GenericModuleItemWidget> createState() => _GenericModuleItemWidgetState();
}

class _GenericModuleItemWidgetState extends State<GenericModuleItemWidget> {
  bool isAnimated = false;

  RiverModuleItem? oldModuleItem;

  @override
  void didUpdateWidget(covariant GenericModuleItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    isAnimated = false;
    oldModuleItem = oldWidget.item;
    if (oldModuleItem == null) {
      isAnimated = false;
      return;
    }
    if (oldWidget.item.isLocked && widget.item.isUnLocked) {
      isAnimated = true;
    } else if (oldWidget.item.isUnLocked && widget.item.isCompleted) {
      isAnimated = true;
    } else if (oldWidget.item.isUnLocked && widget.item.isRead) {
      isAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox.shrink();
    switch (widget.item.itemState) {
      case RiverModuleItemState.locked:
        child = LockedModuleItemWidget(
          icon: widget.item.icon,
          bgColor: widget.item.bgColor,
          iconColor: widget.item.iconColor,
          onTap: widget.onTap,
        );
      case RiverModuleItemState.unlocked:
        child = UnlockedModuleItemWidget(
          icon: widget.item.icon,
          bgColor: widget.item.bgColor,
          iconColor: widget.item.iconColor,
          isAnimated: isAnimated,
          oldBgColor: oldModuleItem?.bgColor,
          onTap: widget.onTap,
        );
      case RiverModuleItemState.read:
        child = ReadModuleItemWidget(
          icon: widget.item.icon,
          bgColor: widget.item.bgColor,
          iconColor: widget.item.iconColor,
          oldBgColor: oldModuleItem?.bgColor,
          isAnimated: isAnimated,
          onTap: widget.onTap,
        );

      case RiverModuleItemState.completed:
        child = CompletedModuleItemWidget(
          icon: widget.item.icon,
          bgColor: widget.item.bgColor,
          iconColor: widget.item.iconColor,
          oldModuleItem: oldModuleItem,
          isAnimated: isAnimated,
          offset: widget.offset,
          onTap: widget.onTap,
        );
    }
    return child;
  }
}
