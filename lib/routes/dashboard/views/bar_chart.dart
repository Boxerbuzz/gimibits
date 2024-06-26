import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import '../../../exports.dart';
import 'lines.dart';

class BarChart extends StatefulWidget {
  final List<Domain> domains;
  final List<charts.Series<Balance, String>> series;
  BarChart(this.domains, this.series)
      : assert(series.length == domains.length),
        assert(series.length == 2);

  @override
  State<StatefulWidget> createState() {
    return _BarChartState();
  }
}

class _BarChartState extends State<BarChart> {
  int currentTab = 0;
  var values = {};

  @override
  void initState() {
    _initializeValues(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_checkValues()) {
      _initializeValues(0);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                widget.domains.map((domain) => _buildDomain(domain)).toList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: _buildBars(),
          ),
        ],
      ),
    );
  }

  bool _checkValues() {
    return values[widget.domains[0].value] ==
            widget.series[0].measureFn(currentTab) &&
        values[widget.domains[1].value] ==
            widget.series[1].measureFn(currentTab);
  }

  void _initializeValues(int index) {
    values[widget.domains[0].value] = widget.series[0].measureFn(index);
    values[widget.domains[1].value] = widget.series[1].measureFn(index);
  }

  Widget _buildDomain(Domain domain) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: domain.color,
            borderRadius: BorderRadius.circular(5.0),
          ),
          width: 18.0,
          height: 18.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "\$${values[domain.value]} ${domain.value}",
            style: TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  double _maxBalance(List<Balance> balances) {
    return balances.map((balance) => balance.money).reduce(max);
  }

  double _getChartVal(double value, double maxValue, double factor) {
    return value / maxValue * factor;
  }

  Widget _buildBars() {
    double maxValue = [
      _maxBalance(widget.series[0].data),
      _maxBalance(widget.series[1].data)
    ].reduce(max);
    double factor = 80.0;
    double width = 20.0;
    return Container(
      height: 240.0,
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            height: 180.0,
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  this.currentTab = index;
                  _initializeValues(index);
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildPlot(
                      _getChartVal(
                          widget.series[0].measureFn(index), maxValue, factor),
                      width,
                      0,
                      widget.domains[0].color,
                      75.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    width: 40.0,
                    child: DashedLine(
                      height: 1.5,
                      color: R.C.kLineColor,
                    ),
                  ),
                  _buildPlot(
                    _getChartVal(
                        widget.series[1].measureFn(index), maxValue, factor),
                    width,
                    2,
                    widget.domains[1].color,
                    75.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      widget.series[0].domainFn(index),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: this.currentTab == index
                              ? Theme.of(context).colorScheme.primary
                              : null),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        itemCount: max(
          widget.series[0].data.length,
          widget.series[1].data.length,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildPlot(height, width, int rotation, color, double maxHeight) {
    return Container(
      height: maxHeight,
      alignment: rotation == 2 ? Alignment.topCenter : Alignment.bottomCenter,
      child: RotatedBox(
        quarterTurns: rotation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.0),
              topRight: Radius.circular(2.0),
            ),
          ),
        ),
      ),
    );
  }
}
