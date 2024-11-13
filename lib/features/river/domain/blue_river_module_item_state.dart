import 'dart:ui';

import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';

class BlueRiverModuleItemState {
  static Color backgroundColor(RiverModuleItemState state) => switch (state) {
        RiverModuleItemState.locked => AppColors.blueLighter,
        RiverModuleItemState.unlocked => AppColors.blueLightest,
        _ => AppColors.blueRegular,
      };

  static Color iconColor(RiverModuleItemState state) => switch (state) {
        RiverModuleItemState.locked => AppColors.blueLightest,
        RiverModuleItemState.unlocked => AppColors.blueRegular,
        _ => AppColors.blueLightest,
      };
}
