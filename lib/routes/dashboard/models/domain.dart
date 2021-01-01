import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class Domain {
  final String value;
  final Color color;

  Domain(this.value, this.color);

  static List<Domain> getDomain(List<String> values, List<Color> colors) {
    assert(values.length == colors.length);
    List<Domain> domains = [];
    for (int i = 0; i < colors.length; i++) {
      domains.add(Domain(values[i], colors[i]));
    }
    return domains;
  }
}

class Balance {
  final String time;
  final double money;

  Balance(this.time, this.money);
}

List<charts.Series<Balance, String>> _getSeries(
    List<String> timeValues, int max) {
  Random rnd = Random();
  var incomeData = timeValues
      .map((value) => Balance(value, rnd.nextInt(max).toDouble()))
      .toList();
  var expenditureData = timeValues
      .map((value) => Balance(value, rnd.nextInt(max).toDouble()))
      .toList();
  return [
    charts.Series<Balance, String>(
      id: 'Income',
      domainFn: (Balance sales, _) => sales.time,
      measureFn: (Balance sales, _) => sales.money,
      data: incomeData,
    ),
    charts.Series<Balance, String>(
        id: "Expenditure",
        domainFn: (Balance balance, _) => balance.time,
        measureFn: (Balance balance, _) => balance.money,
        data: expenditureData)
  ];
}

List<charts.Series<Balance, String>> getSeries(String key, int index,
    {int max = 1000}) {
  var months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  var days = List.generate(
      24, (index) => index < 9 ? "0${index + 1}" : "${index + 1}");
  var years = ["2017", "2018", "2019"];
  var hours = List.generate(24, (index) => "${index + 1}hr");
  var mainMap = {"Year": "Month", "Month": "Day", "Day": "Hour"};
  var subMap = {"Hour": hours, "Day": days, "Month": months, "Year": years};
  var subKey = mainMap[key];
  print("Called");
  return _getSeries(subMap[subKey], max);
}

final Map<String, List<String>> timeValues = {
  "Day": ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],
  "Month": [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ],
  "Year": List.generate(21, (index) => "20${index + 1}").skip(15).toList()
};