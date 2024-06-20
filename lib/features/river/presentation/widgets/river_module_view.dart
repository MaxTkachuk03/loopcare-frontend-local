import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart' as model;
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/generic_module_item_widget.dart';

import '../utils/mock_module_items.dart';
import '../utils/module_items_utils.dart';
import 'animated_river_streams.dart';

class RiverScreen extends StatefulWidget {
  const RiverScreen({
    super.key,
    required this.title,
    required this.page,
    this.completedDate,
    required this.totalDays,
    required this.isCompleted,
    this.items = const [],
  });

  final String title;
  final int page;
  final DateTime? completedDate;
  final int totalDays;
  final bool isCompleted;
  final List<model.RiverModuleItem> items;

  @override
  State<RiverScreen> createState() => _RiverScreenState();
}

class _RiverScreenState extends State<RiverScreen> {
  late List<({Offset offset, model.RiverModuleItem item})> _positionedItems;
  final GlobalKey<AnimatedRiverStreamsState> _riverKey = GlobalKey<AnimatedRiverStreamsState>();

  int get _page => _getIndex(widget.page);

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  List<({Offset offset, model.RiverModuleItem item})> _offsets(List<model.RiverModuleItem> items) {
    final List<({Offset offset, model.RiverModuleItem item})> list = [];

    if (_page == 0) {
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
    _positionedItems = _offsets(widget.items);
    //Todo mocked values
    // _positionedItems = _offsets(items);
  }

  @override
  void didUpdateWidget(covariant RiverScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Todo mocked values
    _positionedItems = _offsets(items);
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
          child: GenericModuleItemWidget(
            item: item,
            onTap: () => _onItemPressed(item),
            offset: Offset(_positionedItems[index].offset.dx, _positionedItems[index].offset.dy),
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
            widget.title,
            style: context.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: itemTopPositionOffset,
          height: dimension,
          width: dimension,
          child: AnimatedRiverStreams(
            key: _riverKey,
            page: _page,
            completedDate: widget.completedDate,
            totalDays: widget.totalDays,
            isCompleted: widget.isCompleted,
          ),
        ),
        ...positionedModuleItems,
      ],
    );
  }

  void _onItemPressed(model.RiverModuleItem item) {
    if (_page == 0) {
      _beginningUnlockAction(item);
    } else {
      // todo: callback for regular items
    }
  }

  void _beginningUnlockAction(model.RiverModuleItem item) {
    if (item.itemState.isCompleted) {
      return;
    }

    final bloc = context.read<NavigationBarBloc>();

    if (item.iconType == RiverIconType.practice) {
      ModalBottomSheet.guidancePractice(
        context: context,
        onConfirm: () => bloc.add(const NavigationBarEvent.unlockPractise()),
      );
    }

    if (item.iconType == RiverIconType.profile) {
      ModalBottomSheet.guidanceProfile(
        context: context,
        onConfirm: () => bloc.add(const NavigationBarEvent.unlockProfile()),
      );
    }
  }
}
