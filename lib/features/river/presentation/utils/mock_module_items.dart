import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

const items =  [
  RiverModuleItem(
    itemState: RiverModuleItemState.locked,
    iconType: RiverIconType.reflection,
    streamType: RiverModuleStreamType.psychology,
    featurePlacement: null,
  ),
  RiverModuleItem(
    itemState: RiverModuleItemState.locked,
    iconType: RiverIconType.medical,
    streamType: RiverModuleStreamType.medical,
    featurePlacement: null,
  ),
  RiverModuleItem(
    itemState: RiverModuleItemState.locked,
    iconType: RiverIconType.buddy,
    streamType: RiverModuleStreamType.community,
    featurePlacement: null,
  ),
  RiverModuleItem(
    itemState: RiverModuleItemState.locked,
    iconType: RiverIconType.community,
    streamType: RiverModuleStreamType.community,
    featurePlacement: null,
  ),
];