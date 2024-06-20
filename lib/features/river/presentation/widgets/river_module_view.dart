import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/generic_module_item_widget.dart';

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
  late List<({Offset offset, ModelItem item})> _positionedItems;
  final GlobalKey<AnimatedRiverStreamsState> _riverKey = GlobalKey<AnimatedRiverStreamsState>();

  int get _page => _getIndex(widget.page);

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  List<({Offset offset, ModelItem item})> _offsets(List<ModelItem> items) {
    final List<({Offset offset, ModelItem item})> list = [];

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
    _positionedItems = _offsets(items);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dimension = size.width;
    final itemTopPositionOffset = (size.height - dimension) / 2.5;

    final positions = List.generate(
      _positionedItems.length,
      (index) => Positioned(
          left: dimension * _positionedItems[index].offset.dx - 22,
          top: itemTopPositionOffset + dimension * _positionedItems[index].offset.dy - 22,
          //Todo ModuleItem widget
          child: GenericModuleItemWidget(
              item: const RiverModuleItem(
                itemState: RiverModuleItemState.completed,
                iconType: RiverIconType.reflection,
                streamType: RiverModuleStreamType.nutrition,
                featurePlacement: null,
              ),
              offset: Offset(_positionedItems[index].offset.dx, _positionedItems[index].offset.dy))
          // CircleAvatar(
          //   radius: 22,
          //   child: Text(_positionedItems[index].item.stream.streamIndex.toString()),
          // ),
          ),
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
        ...positions,
      ],
    );
  }
}

const List<ModelItem> zeroItems = [
  ModelItem(id: 1, stream: RiverStreamType.psychology, isRoot: true),
  ModelItem(id: 2, stream: RiverStreamType.psychology),
  ModelItem(id: 3, stream: RiverStreamType.psychology),
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

  int get streamIndex => switch (this) {
        activity => 0,
        community => 1,
        psychology => 2,
        medical => 3,
        nutrition => 4,
      };

  Color get streamColor {
    switch (this) {
      case RiverStreamType.psychology:
        return AppColors.petrolRegular;
      case RiverStreamType.nutrition:
        return AppColors.greenRegular;
      case RiverStreamType.activity:
        return AppColors.yellowRegular;
      case RiverStreamType.medical:
        return AppColors.coralRegular;
      case RiverStreamType.community:
        return AppColors.orangeRegular;
    }
  }

  Color get lighterColor {
    switch (this) {
      case RiverStreamType.psychology:
        return AppColors.petrolLightest;
      case RiverStreamType.nutrition:
        return AppColors.greenLightest;
      case RiverStreamType.activity:
        return AppColors.yellowLightest;
      case RiverStreamType.medical:
        return AppColors.coralLightest;
      case RiverStreamType.community:
        return AppColors.orangeLightest;
    }
  }
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
