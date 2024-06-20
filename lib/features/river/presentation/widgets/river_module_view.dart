import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/module_item/module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item/river_module_item_utils.dart';

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
  final List<ModelItem> items;

  @override
  State<RiverScreen> createState() => _RiverScreenState();
}

class _RiverScreenState extends State<RiverScreen> {
  late List<({Offset offset, ModuleItem item})> _positionedItems;
  final GlobalKey<AnimatedRiverStreamsState> _riverKey = GlobalKey<AnimatedRiverStreamsState>();
  
  int get _page => _getIndex(widget.page);

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  List<({Offset offset, ModuleItem item})> _offsets(List<ModuleItem> items) {
    final List<({Offset offset, ModuleItem item})> list = [];

    if (_page == 0) {
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        list.add((offset: ModuleItemsUtils.zeroPagePositions[i], item: item));
      }

      return list;
    }

    final activity = items.where((element) => element.stream.isActivity).toList();
    final community = items.where((element) => element.stream.isCommunity).toList();
    final psychology = items.where((element) => element.stream.isPsychology).toList();
    final medical = items.where((element) => element.stream.isMedical).toList();
    final nutrition = items.where((element) => element.stream.isNutrition).toList();

    final streams = [psychology, community, medical, activity, nutrition];

    for (final listItems in streams) {
      for (int i = 0; i < listItems.length; i++) {
        final item = listItems[i];
        if (!item.isRoot) {
          final position = ModuleItemsUtils.getOffset(_page, i, item.stream.streamIndex);
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
    _positionedItems = _offsets(zeroItems);
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
        final radius = item.isRoot ? 36.0 : 25.0;
        return Positioned(
          left: dimension * offset.dx - radius,
          top: itemTopPositionOffset + dimension * offset.dy - radius,
          child: RiverModuleItem(
            item: item,
            circleRadius: radius,
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

  void _onItemPressed(ModuleItem item) {
    if (_page == 0) {
      _beginningUnlockAction(item);
    } else {
      // todo: callback for regular items
    }
  }

  void _beginningUnlockAction(ModuleItem item) {
    if (item.state.isCompleted) {
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

List<ModuleItem> zeroItems = [
  ModuleItem(
    state: RiverModuleItemState.unlock,
    iconType: RiverIconType.reflection,
    stream: RiverModuleStreamType.beginning,
    isRoot: true,
  ),
  ModuleItem(
    state: RiverModuleItemState.unlock,
    iconType: RiverIconType.practice,
    stream: RiverModuleStreamType.beginning,
  ),
  ModuleItem(
    state: RiverModuleItemState.unlock,
    iconType: RiverIconType.profile,
    stream: RiverModuleStreamType.beginning,
  ),
];

const List<ModelItem> items = [
  ModelItem(id: 1, stream: RiverStreamType.psychology, isRoot: true),
  // ModelItem(id: 2, stream: 0),
  ModelItem(id: 6, stream: RiverStreamType.activity),
  ModelItem(id: 3, stream: RiverStreamType.community),
  // ModelItem(id: 11, stream: 1),
  // ModelItem(id: 9, stream: 2),
  ModelItem(id: 4, stream: RiverStreamType.medical),
  // ModelItem(id: 10, stream: 3),
  // ModelItem(id: 5, stream: 4),
  // ModelItem(id: 7, stream: 4),
  ModelItem(id: 8, stream: RiverStreamType.nutrition),
];

enum RiverStreamType {
  activity,
  community,
  psychology,
  medical,
  nutrition;

  const RiverStreamType();

  bool get isActivity => this == activity;

  bool get isCommunity => this == community;

  bool get isPsychology => this == psychology;

  bool get isMedical => this == medical;

  bool get isNutrition => this == nutrition;

  int get streamIndex => switch(this) {
    activity => 0,
    community => 1,
    psychology => 2,
    medical => 3,
    nutrition => 4,
  };
}

class ModelItem {
  final int id;
  final RiverStreamType stream;
  final bool isRoot;

  const ModelItem({
    required this.id,
    required this.stream,
    this.isRoot = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ModelItem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              stream == other.stream &&
              isRoot == other.isRoot;

  @override
  int get hashCode => id.hashCode ^ stream.hashCode ^ isRoot.hashCode;
}
