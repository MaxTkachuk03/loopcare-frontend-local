import 'dart:math' as math;
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/function_coefficients.dart';

const List<Offset> _zeroPagePositions = [
  Offset(0.76, 0.62),
  Offset(0.88, 0.45),
  Offset(0.59, 0.54),
];

const Offset _zeroPageRootItemPosition = Offset(0.39, 0.31);

class ModuleItemsUtils {
  static Offset get zeroPageRootItemPosition => _zeroPageRootItemPosition;

  static Offset _getRootOffset(int page) {
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

  static List<({Offset offset, RiverModuleItem item})> getAllocatedItems(
    int page,
    List<RiverModuleItem> items,
  ) {
    if (page == 0) {
      return _getBeginningPageOffsets(items);
    } else {
      return _getItemsOffsetForPage(page, items);
    }
  }

  static List<({Offset offset, RiverModuleItem item})> _getBeginningPageOffsets(
    List<RiverModuleItem> items,
  ) {
    final List<({Offset offset, RiverModuleItem item})> list = [];

    final rootItem = items.firstWhereOrNull((i) => i.isRootItem);
    final regularItems = items.where((i) => !i.isRootItem).toList();

    if (rootItem != null) {
      list.add((offset: _zeroPageRootItemPosition, item: rootItem));
    }

    for (int i = 0; i < regularItems.length; i++) {
      final item = regularItems[i];
      list.add((offset: _zeroPagePositions[i], item: item));
    }

    return list;
  }

  static List<({Offset offset, RiverModuleItem item})> _getItemsOffsetForPage(
    int page,
    List<RiverModuleItem> items,
  ) {
    final List<({Offset offset, RiverModuleItem item})> list = [];

    final root = items.where((i) => i.isRootItem).toList();
    final activity = items.where((i) => i.streamType.isPhysicalActivity && !i.isRootItem).toList();
    final community = items.where((i) => i.streamType.isCommunity && !i.isRootItem).toList();
    final psychology = items.where((i) => i.streamType.isPsychology && !i.isRootItem).toList();
    final medical = items.where((i) => i.streamType.isMedical && !i.isRootItem).toList();
    final nutrition = items.where((i) => i.streamType.isNutrition && !i.isRootItem).toList();

    final streams = [psychology, community, medical, activity, nutrition];
    streams.sort((a, b) => b.length.compareTo(a.length));
    streams.insert(0, root);

    final ranges = RangeBox();

    for (final listItems in streams) {
      for (int i = 0; i < listItems.length; i++) {
        final item = listItems[i];

        final range = ranges.elementAt(item.streamType.streamIndex);

        if (item.isRootItem) {
          final offset = _getRootOffset(page);
          list.add((offset: offset, item: item));
          ranges.insertGaps(2, 0.5);
        } else {
          final biggestRanges = range.biggest;
          double position;

          if (biggestRanges.any((e) => e.inRange(0.1))) {
            position = 0.1;
          } else if (biggestRanges.any((e) => e.inRange(0.9)) && (i == 0 || listItems.length > 2)) {
            position = 0.9;
          } else {
            final range = (item.streamType.streamIndex + page).isOdd
                ? biggestRanges.first
                : biggestRanges.last;
            position = range.middle;
          }

          final offset = _getOffset(position, page, item.streamType.streamIndex);
          list.add((offset: offset, item: item));
          ranges.insertGaps(item.streamType.streamIndex, position);
        }
      }
    }

    return list;
  }
}

class RangeBox {
  final List<RangeLine> _ranges;

  RangeBox() : _ranges = List.generate(5, (_) => RangeLine.fill());

  int get length => _ranges.length;

  RangeLine elementAt(int index) => _ranges.elementAt(index);

  void insertGaps(int streamIndex, double gapPosition) {
    for (int i = 0; i < _ranges.length; i++) {
      final gapWidth = i >= streamIndex - 1 && i <= streamIndex + 1 ? 0.15 : 0.0;
      _ranges[i].insertGap(gapPosition, itemWidth: gapWidth);
    }
  }
}

class RangeLine {
  final List<DoubleRange> _list;

  RangeLine.fromIterable(Iterable<DoubleRange> list) : _list = list.toList();

  RangeLine.fill() : _list = [const DoubleRange.fill()];

  int get length => _list.length;

  List<DoubleRange> get biggest {
    if (_list.isEmpty) return [];

    return _list.where((e) => e.length == _list.first.length).toList();
  }

  RangeLine insertGap(double position, {double itemWidth = 0.0}) {
    final list = _list;
    final index = list.indexWhere((r) => r.inRange(position));

    if (index.isNegative) return this;

    final rangeItem = list.elementAt(index);
    final newRanges = rangeItem.insertInRange(position, itemWidth: itemWidth);

    list.replaceRange(index, index + 1, newRanges);
    list.sort((a, b) => b.length.compareTo(a.length));

    return RangeLine.fromIterable(list);
  }

  bool isAvailablePosition(double value) => _list.any((r) => r.inRange(value));

  @override
  String toString() => _list.toString();
}

class DoubleRange {
  final double from;
  final double to;

  const DoubleRange(this.from, this.to);

  const DoubleRange.fill()
      : from = 0.0,
        to = 1.0;

  double get length => (to - from).abs();

  double get middle => from + (to - from) / 1.7;

  bool inRange(double value) => value > from && value < to;

  List<DoubleRange> insertInRange(double position, {double itemWidth = 0.0}) {
    if (!inRange(position)) {
      throw _OutOfRangeException(this, position);
    }

    if (position == from || position == to) {
      return [this];
    }
    return [DoubleRange(from, position - itemWidth / 2), DoubleRange(position + itemWidth / 2, to)];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoubleRange &&
          runtimeType == other.runtimeType &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;

  @override
  String toString() {
    return 'DoubleRange($from, $to)';
  }
}

final class _OutOfRangeException implements Exception {
  @pragma("vm:entry-point")
  const _OutOfRangeException(this.range, this.position);

  final DoubleRange range;
  final double position;

  @override
  String toString() => "Out of DoubleRange, ${range.from}..${range.to} : $position";
}
