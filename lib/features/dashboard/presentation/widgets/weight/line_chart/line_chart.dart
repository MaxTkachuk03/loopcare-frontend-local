import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import '../../../../../../core/presentation/text/custom_text.dart';
import '../../../../../../core/presentation/themes/themes.dart';

class LineChartWidget extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final List<Map<String, double>> spots;
  final double yMax;
  final double xMax;
  final double lastDatePlacement;
  final Color mainLineColor;
  final Color secondaryLineColor;

  const LineChartWidget({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.spots,
    required this.yMax,
    required this.xMax,
    required this.lastDatePlacement,
    required this.mainLineColor,
    required this.secondaryLineColor,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  static const double defaultMin = 0.0;

  @override
  Widget build(BuildContext context) {
    List<FlSpot> adjustedSpots = widget.spots.map((el) => FlSpot(el['x']!, el['y']!)).toList();
    final lastSpot = adjustedSpots.last;
    final maxSpot = widget.spots.map((s) => s['y']!).reduce((a, b) => a > b ? a : b);

    final verticalLineToTopSpots = [
      FlSpot(lastSpot.x, lastSpot.y),
      FlSpot(lastSpot.x, maxSpot),
    ];

    final horizontalDashedSpots = [
      FlSpot(lastSpot.x, lastSpot.y),
      FlSpot(lastSpot.x + (widget.xMax - lastSpot.x) / 4, lastSpot.y + 5),
      FlSpot(lastSpot.x + (widget.xMax - lastSpot.x) / 2, lastSpot.y - 5),
      FlSpot(lastSpot.x + (widget.xMax - lastSpot.x) * 3 / 4, lastSpot.y + 5),
      FlSpot(lastSpot.x + (widget.xMax - lastSpot.x), lastSpot.y - 5),
    ];

    final verticalDashedLineSpots = [
      FlSpot(lastSpot.x, lastSpot.y),
      FlSpot(lastSpot.x, 0),
    ];

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 22,
              left: 22,
              bottom: 24,
            ),
            child: LineChart(
              mainData(adjustedSpots, horizontalDashedSpots, verticalDashedLineSpots,
                  verticalLineToTopSpots),
            ),
          ),
        ),
      ],
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    final lastSpotTitle = '${widget.lastDate.day} ${widget.lastDate.shortMonthString}';
    final lastDatePlacement = widget.lastDatePlacement;

    const style = TextStyle(fontSize: 11, color: AppColors.white);
    String text;

    if (value == lastDatePlacement) {
      text = widget.lastDate.isToday ? 'today' : lastSpotTitle;
    } else {
      text = '';
    }

    return SideTitleWidget(
        axisSide: AxisSide.left,
        child: Row(
          children: [
            if (value == lastDatePlacement)
              Container(
                alignment: Alignment.center,
                width: 45,
                height: 23,
                decoration: BoxDecoration(
                    color: AppColors.blueDarker, borderRadius: BorderRadius.circular(20)),
                child: CustomText.w400(text, style: style),
              ),
            if (value != lastDatePlacement) CustomText.w400(text, style: style),
          ],
        ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final firstDate = '${widget.firstDate.day} ${widget.firstDate.shortMonthString}';

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;

    if (value == 1.0) {
      text = Text(firstDate, style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: AxisSide.left,
      child: text,
    );
  }

  LineChartData mainData(List<FlSpot> spots, List<FlSpot> horizontalDashedLineSpots,
      List<FlSpot> verticalDashedLineSpots, List<FlSpot> verticalLineToTopSpots) {
    return LineChartData(
      lineTouchData: const LineTouchData(
        handleBuiltInTouches: false,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(
            color: widget.secondaryLineColor,
          ))),
      minX: defaultMin,
      maxX: widget.xMax,
      minY: defaultMin,
      maxY: widget.yMax,
      lineBarsData: [
        LineChartBarData(
          dashArray: [10, 5],
          spots: verticalLineToTopSpots,
          isCurved: false,
          color: widget.secondaryLineColor,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: true, color: AppColors.transparent),
        ),
        if (widget.lastDatePlacement != widget.xMax)
          LineChartBarData(
            dashArray: [
              5,
              10,
            ],
            spots: verticalDashedLineSpots,
            isCurved: true,
            color: widget.secondaryLineColor,
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: AppColors.transparent),
          ),
        if (widget.lastDatePlacement != widget.xMax)
          LineChartBarData(
            dashArray: [
              3,
              10,
            ],
            spots: horizontalDashedLineSpots,
            isCurved: true,
            color: widget.secondaryLineColor,
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: AppColors.transparent),
          ),
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: widget.mainLineColor,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
              getDotPainter: (spot, _, __, ___) {
                return FlDotCirclePainter(
                  radius: 10,
                  color: widget.mainLineColor,
                  strokeColor: Colors.white,
                  strokeWidth: 4,
                );
              },
              checkToShowDot: (spot, _) {
                final lastSpot = spots.last;
                return spot.y == lastSpot.y && spot.x == lastSpot.x;
              },
              show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                widget.mainLineColor,
                widget.mainLineColor.withOpacity(0.5),
                widget.mainLineColor.withOpacity(0.2),
              ],
              stops: const [0.0, 0.8, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
