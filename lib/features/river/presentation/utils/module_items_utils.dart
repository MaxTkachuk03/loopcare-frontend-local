import 'dart:math' as math;
import 'dart:ui';

import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

import 'function_coefficients.dart';

const List<Offset> _zeroPagePositions = [
  Offset(0.76, 0.62),
  Offset(0.88, 0.45),
];

const Offset _startButtonPosition = Offset(0.39, 0.31);

class ModuleItemsUtils {
  static get zeroPagePositions => _zeroPagePositions;

  static get startButtonPosition => _startButtonPosition;

  static Offset getOffset(int page, int itemIndex, int stream) {
    final dx = ItemsPositions(page).values.elementAt(stream, itemIndex);
    return _getOffset(dx, page, stream);
  }

  static Offset getRootOffset(int page) {
    const dx = 0.5;
    return _getOffset(dx, page, 2);
  }

  static Offset _getOffset(double dx, int page, int stream) {
    final dy = (1 - _g(FunctionCoefficients(page).values.elementAt(stream), dx));
    return Offset(dx, dy);
  }

  static double _f(double x) => (math.pow(x, 2)) + math.sin(3 * x);

  static double _g(List<double> constants, double x) {
    assert(constants.length == 4);

    final a = constants[0];
    final b = constants[1];
    final c = constants[2];
    final d = constants[3];

    return d + a * _f((x - c) / b);
  }

  static List<({Offset offset, RiverModuleItem item})> getItemsOffsets(int page, List<RiverModuleItem> items) {
    if (page == 0) {
      return _getBeginningPageOffsets(items);
    } else {
      return _getItemsOffsetForPage(page, items);
    }
  }

  static List<({Offset offset, RiverModuleItem item})> _getBeginningPageOffsets(List<RiverModuleItem> items) {
    final List<({Offset offset, RiverModuleItem item})> list = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      list.add((offset: ModuleItemsUtils.zeroPagePositions[i], item: item));
    }

    return list;
  }

  static List<({Offset offset, RiverModuleItem item})> _getItemsOffsetForPage(int page, List<RiverModuleItem> items) {
    final List<({Offset offset, RiverModuleItem item})> list = [];

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
          final position = ModuleItemsUtils.getOffset(page, i, item.streamType.streamIndex);
          list.add((offset: position, item: item));
        } else {
          final position = ModuleItemsUtils.getRootOffset(page);
          list.add((offset: position, item: item));
        }
      }
    }

    return list;
  }
}