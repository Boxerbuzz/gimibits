import 'package:fl_chart/fl_chart.dart' as chart;
import 'package:flutter/material.dart';

import '../../../exports.dart';

class WeeklyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: chart.BarChart(
        chart.BarChartData(
          barGroups: getBarGroups(context),
          borderData: chart.FlBorderData(show: false),
          titlesData: chart.FlTitlesData(
            leftTitles: chart.SideTitles(showTitles: false),
            bottomTitles: chart.SideTitles(
              showTitles: true,
              getTitles: getWeek,
              getTextStyles: (double) {
                return TextStyle(
                  color: AppTheme.getColor(context),
                  fontSize: 10.0,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

getBarGroups(context) {
  List<double> barChartData = [6, 10, 8, 7, 10, 15, 9];
  List<chart.BarChartGroupData> barChartGroups = [];
  barChartData.asMap().forEach(
        (i, value) => barChartGroups.add(
          chart.BarChartGroupData(
            x: i,
            barRods: [
              chart.BarChartRodData(
                y: value,
                //This is not the proper way, this is just for demo
                colors: [
                  i == 4
                      ? Theme.of(context).colorScheme.primary
                      : AppTheme.kInactiveChartColor
                ],
                width: 16,
              )
            ],
          ),
        ),
      );
  return barChartGroups;
}

String getWeek(double value) {
  switch (value.toInt()) {
    case 0:
      return 'MON';
    case 1:
      return 'TUE';
    case 2:
      return 'WED';
    case 3:
      return 'THU';
    case 4:
      return 'FRI';
    case 5:
      return 'SAT';
    case 6:
      return 'SUN';
    default:
      return '';
  }
}
