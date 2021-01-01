import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class MiniChart extends StatelessWidget {
  final Color color;
  final List<double> spots;

  MiniChart({this.color, this.spots});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          clipData: FlClipData.all(),

          lineBarsData: [
            LineChartBarData(
              spots: getSports(spots ?? mockChart),
              isCurved: true,
              curveSmoothness: 0.5,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [color],
              barWidth: 2,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports(List spots) {
    List<FlSpot> list = [];

    for (int i = 0; i < spots.length; i++) {
      list.add(FlSpot(i.toDouble(), spots[i]));
    }
    return list;
  }
}
