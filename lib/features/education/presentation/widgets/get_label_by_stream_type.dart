import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

Widget getLabelByStreamType(RiverModuleStreamType streamType) {
  switch (streamType) {
    case RiverModuleStreamType.physicalActivity:
      return CategoryLabel.physicalActivity();
    case RiverModuleStreamType.psychology:
      return CategoryLabel.psychology();
    case RiverModuleStreamType.nutrition:
      return CategoryLabel.nutrition();
    case RiverModuleStreamType.medical:
      return CategoryLabel.medical();
    case RiverModuleStreamType.community:
      return CategoryLabel.community();
  }
}
