import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../exports.dart';

class GBMarketDetail extends StatefulWidget {
  @override
  _GBMarketDetailState createState() => _GBMarketDetailState();
}

class _GBMarketDetailState extends State<GBMarketDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _onIntLoading();
    _tabController = TabController(length: tabs().length, vsync: this);
  }

  _onIntLoading() {
    final _store = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _store.isLoading(true);
      //await _store.fetchOHLC('btcusd');
      _store.isLoading(false);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cc = Theme.of(context).colorScheme;
    final _store = Provider.of<MainProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      'BTC/USDT',
                      style: GoogleFonts.barlow(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(child: Container()),
                    IconWidget(iconPath: R.I.icStar, padding: 4.0),
                    SizedBox(width: 10.0),
                    IconWidget(iconPath: R.I.icShare, padding: 4.0),
                    SizedBox(width: 10.0),
                    IconWidget(iconPath: R.I.icMax, padding: 4.0),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '18000.094',
                            style: GoogleFonts.barlow(
                              fontSize: 40.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                '= 18,000.948 USD',
                                style: GoogleFonts.barlow(),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '+0.149 %',
                                style: GoogleFonts.barlow(),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                          Expanded(child: Container()),
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoSlidingSegmentedControl(
                              children: duration,
                              groupValue: 'Month',
                              onValueChanged: (val) {},
                              thumbColor: cc.primaryVariant,
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: AppTheme.viewportHeight(context) * 0.4,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    child: Stack(
                      children: [
                        _store.load == true
                            ? SpinKitThreeBounce(
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                                duration: Duration(milliseconds: 1500),
                              )
                            : SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                title: ChartTitle(text: ''),
                                primaryXAxis: DateTimeAxis(
                                  dateFormat: DateFormat.MMM(),
                                  interval: 3,
                                  intervalType: DateTimeIntervalType.auto,
                                  minimum: DateTime(2016, 01, 01),
                                  maximum: DateTime(2016, 10, 01),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                    minimum: 140,
                                    maximum: 80,
                                    interval: 20,
                                    labelFormat: '\${value}',
                                    axisLine: AxisLine(width: 0),
                                    rangePadding: ChartRangePadding.none),
                                series: OHCL.getCandleSeries(),
                                trackballBehavior: TrackballBehavior(
                                  enable: false,
                                  activationMode: ActivationMode.longPress,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 0.0),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppTheme.viewportHeight(context) * .7,
                    child: InfoTabs(
                      tabController: _tabController,
                      tabs: tabs(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AppTheme.viewportWidth(context) * 0.45,
                  child: BoxPanel(
                    color: R.C.kGreenColor,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'Buy',
                          style: tt.headline4,
                        ),
                      ),
                    ),
                  ),
                ).ripple(onTap: () {}),
                SizedBox(
                  width: AppTheme.viewportWidth(context) * 0.45,
                  child: BoxPanel(
                    color: R.C.kRedColor,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'Sell',
                          style: tt.headline4,
                        ),
                      ),
                    ),
                  ),
                ).ripple(onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
