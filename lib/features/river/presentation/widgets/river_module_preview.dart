import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_item_preview.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/module_items_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_builder.dart';

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
      padding: const EdgeInsets.only(left: 20),
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
        enableGradient: module.moduleItems.any((i) => !i.isLocked),
        index: getIndex(page),
        completedDate: module.nextModuleUnlocksAt,
        totalDelay: module.nextModuleUnlockDelay,
        isCompleted: module.isCompleted,
        title: module.title,
        positionedItems: positionedItems,
        itemBuilder: (context, index) {
          final item = positionedItems[index].item;
          final radius = itemRadius(isOverview: true);

          return RiverModuleItemPreview(
            item: item,
            radius: radius,
            isBeginning: isBeginning,
          );
        },
      ),
    );
  }
}
