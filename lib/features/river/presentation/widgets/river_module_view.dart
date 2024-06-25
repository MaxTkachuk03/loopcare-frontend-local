import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart' as model;
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_animation_module_item_widget.dart';

import '../utils/module_items_utils.dart';
import 'animated_river_streams.dart';

class RiverScreen extends StatefulWidget {
  const RiverScreen({
    super.key,
    required this.module,
    required this.page,
  });

  final RiverModule module;
  final int page;

  @override
  State<RiverScreen> createState() => _RiverScreenState();
}

class _RiverScreenState extends State<RiverScreen> {
  late List<({Offset offset, model.RiverModuleItem item})> _positionedItems;
  late int _page;

  bool get _isTheBeginningModule => _page == 0;

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  List<({Offset offset, model.RiverModuleItem item})> _offsets(List<model.RiverModuleItem> items) {
    final List<({Offset offset, model.RiverModuleItem item})> list = [];

    if (_isTheBeginningModule) {
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        list.add((offset: ModuleItemsUtils.zeroPagePositions[i], item: item));
      }

      return list;
    }

    final activity = items.where((element) => element.streamType.isPhysicalActivity).toList();
    final community = items.where((element) => element.streamType.isCommunity).toList();
    final psychology = items.where((element) => element.streamType.isPsychology).toList();
    final medical = items.where((element) => element.streamType.isMedical).toList();
    final nutrition = items.where((element) => element.streamType.isNutrition).toList();

    final streams = [psychology, community, medical, activity, nutrition];

    for (final listItems in streams) {
      for (int i = 0; i < listItems.length; i++) {
        final item = listItems[i];
        if (!item.isRootItem) {
          final position = ModuleItemsUtils.getOffset(_page, i, item.streamType.streamIndex);
          list.add((offset: position, item: item));
        } else {
          final position = ModuleItemsUtils.getRootOffset(_page);
          list.add((offset: position, item: item));
        }
      }
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    _page = _getIndex(widget.page);
    _positionedItems = _offsets(widget.module.moduleItems);
  }

  @override
  void didUpdateWidget(covariant RiverScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.module.moduleItems.equals(oldWidget.module.moduleItems)) {
      _positionedItems = _offsets(widget.module.moduleItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dimension = size.width;
    final itemTopPositionOffset = (size.height - dimension) / 2.5;

    final positionedModuleItems = List.generate(
      _positionedItems.length,
      (index) {
        final offset = _positionedItems[index].offset;
        final item = _positionedItems[index].item;
        final radius = item.isRootItem ? 36.0 : 25.0;
        return Positioned(
          left: dimension * offset.dx - radius,
          top: itemTopPositionOffset + dimension * offset.dy - radius,
          child: RiverAnimationModuleItemWidget(
            item: item,
            radius: radius,
            onTap: () => _onItemPressed(item),
          ),
        );
      },
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 20.0,
          child: CustomText.bitter600(
            widget.module.title,
            style: context.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: itemTopPositionOffset,
          height: dimension,
          width: dimension,
          child: AnimatedRiverStreams(
              page: _page,
              completedDate: widget.module.nextModuleUnlocksAt,
              totalDelay: widget.module.nextModuleUnlockDelay,
              isCompleted: widget.module.isCompleted,
              onCompleted: _onCompleteTime),
        ),
        ...positionedModuleItems,
      ],
    );
  }

  void _onItemPressed(model.RiverModuleItem item) {
    if (_isTheBeginningModule) {
      _beginningUnlockAction(item);
    } else {
      // todo: callback for regular items
    }
  }

  void _beginningUnlockAction(model.RiverModuleItem item) {
    if (item.itemState.isCompleted) {
      return;
    }

    final barBloc = context.read<NavigationBarBloc>();
    final riverBloc = context.read<RiverBloc>();

    if (item.iconType == RiverIconType.practice) {
      ModalBottomSheet.guidancePractice(
        context: context,
        onConfirm: () {
          barBloc.add(const NavigationBarEvent.unlockPractise());
          riverBloc.add(
            RiverEvent.updateModuleItem(
              moduleId: widget.module.id,
              moduleItemId: item.id,
            ),
          );
        },
      );
    }

    if (item.iconType == RiverIconType.profile) {
      ModalBottomSheet.guidanceProfile(
        context: context,
        onConfirm: () {
          barBloc.add(const NavigationBarEvent.unlockProfile());
          riverBloc.add(
            RiverEvent.updateModuleItem(
              moduleId: widget.module.id,
              moduleItemId: item.id,
            ),
          );
        },
      );
    }
  }

  void _onCompleteTime() {
    if (_isTheBeginningModule) {
      ModalBottomSheet.guidanceCompleted(context: context);
    } else {
      _onComplete();
    }
  }

  void _onComplete() {
    context.read<RiverBloc>().add(
          RiverEvent.updateModule(moduleId: widget.module.id),
        );
  }
}
