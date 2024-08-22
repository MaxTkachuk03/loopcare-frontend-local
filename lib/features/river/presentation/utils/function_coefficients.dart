import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_stream_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_five_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_four_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_one_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_three_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_two_painter.dart';

class FunctionCoefficients {
  final int index;

  const FunctionCoefficients(this.index);

  FunctionCoefficientsValues get values => switch (index) {
    1 => const FunctionCoefficientsOne(),
    2 => const FunctionCoefficientsTwo(),
    3 => const FunctionCoefficientsThree(),
    4 => const FunctionCoefficientsFour(),
    _ => const FunctionCoefficientsFive(),
  };
}

class ItemsPositions {
  final int index;

  const ItemsPositions(this.index);

  ItemsPositionValues get values => switch (index) {
    1 => const ItemsPositionsOne(),
    2 => const ItemsPositionsTwo(),
    3 => const ItemsPositionsThree(),
    4 => const ItemsPositionsFour(),
    _ => const ItemsPositionsFive(),
  };
}