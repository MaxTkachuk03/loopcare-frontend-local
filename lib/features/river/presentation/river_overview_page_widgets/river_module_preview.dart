import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/module_items_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_builder.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_item_widget/river_module_item_preview.dart';

class RiverModulePreview extends StatelessWidget with RiverUtils {
  const RiverModulePreview({
    super.key,
    required this.module,
    required this.page,
  });

  final RiverModule module;
  final int page;

  @override
  bool get isBeginning => page == 0;

  @override
  Widget build(BuildContext context) {
    final positionedItems = ModuleItemsUtils.getAllocatedItems(getIndex(page), module.moduleItems);

    return Container(
      height: kDefaultModuleHeight,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0x00ECF5FF).withOpacity(1),
            const Color(0x00c6ddf6).withOpacity(0.8),
          ],
        ),
      ),
      child: RiverModuleBuilder(
        isOverview: true,
        enableGradient: module.moduleItems.any((i) => !i.states.prevItemState.isLocked),
        index: getIndex(page),
        completedDate: module.nextModuleUnlocksAt,
        totalDelay: module.nextModuleUnlockDelay,
        isCompleted: module.isCompleted,
        title: module.title,
        positionedItems: positionedItems,
        itemBuilder: (context, item) {
          return RiverModuleItemPreview(
            item: item,
            radius: itemRadius(isRoot: item.isRootItem, isOverview: true),
            isBeginning: isBeginning,
          );
        },
      ),
    );
  }
}
