import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GBDashboard extends StatefulWidget {
  static Screen gmDashboard = Screen(
    title: 'GIMIBITS',
    contentBuilder: (context) => GBDashboard(),
  );

  @override
  _GBDashboardState createState() => _GBDashboardState();
}

class _GBDashboardState extends State<GBDashboard> {
  String mainValue = "Year";
  int subIndex = 0;
  int _currentIndexUp = 0;
  int _currentIndex = 0;
  List<charts.Series<Balance, String>> series;
  ScrollController ctrl;

  @override
  void initState() {
    series = getSeries(mainValue, subIndex, max: 10);
    ctrl = ScrollController();
    super.initState();
    updateData();
  }

  updateData() async {
    Timer(Duration(milliseconds: 800), () {
      setState(() {
        series = getSeries(mainValue, subIndex, max: 1000);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        autoPlayInterval: Duration(seconds: 10),
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        pauseAutoPlayOnTouch: true,
                        autoPlayCurve: Curves.easeInOut,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                            print(_currentIndex);
                          });
                        },
                      ),
                      items: carouselSliderList(banners),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: FutureBuilder<List<TopPair>>(
                        future: _store.fetchTopPairs(),
                        builder: (context, data) {
                          if (data.connectionState == ConnectionState.waiting &&
                              _store.topPairs.length == 0) {
                            return Column(
                              children: [],
                            );
                          }
                          return Container(
                            child: CarouselSlider(
                              items: List<GridView>.generate((2), (int index) {
                                return GridView.count(
                                  crossAxisCount: 3,
                                  controller: ctrl,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: List<TopPairsItem>.generate((3),
                                      (int index) {
                                    return TopPairsItem(_store.topPairs[
                                        index + (_currentIndexUp * 4)]);
                                  }),
                                );
                              }),
                              options: CarouselOptions(
                                aspectRatio: 5,
                                viewportFraction: 1.0,
                                initialPage: 0,
                                enlargeCenterPage: true,
                                autoPlay: false,
                                scrollPhysics: BouncingScrollPhysics(),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndexUp = index;
                                    print(_currentIndexUp);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: .3,
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(2, (int index) {
                        return dots(_currentIndexUp, index);
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            BoxPanel(
              radius: 15.0,
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: IconWidget(iconPath: R.I.icWallet, size: 30.0),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy Crypto',
                        style: GoogleFonts.barlow(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Buy and sell digital assets',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: ()=> Navigator.of(context).push(
                      MaterialPageRoute(builder: (_)=> OnScreenKeyboard())
                    ),
                    child: Container(
                      height: 25,
                      width: 25.0,
                      child: IconWidget(
                        iconPath: R.I.icRightArrow,
                        padding: 2.0,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            BoxPanel(
              radius: 15.0,
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  DateRangeSelector(
                    timeValues,
                    (mainValue, subIndex) {
                      setState(() {
                        if (this.mainValue != mainValue)
                          this.mainValue = mainValue;
                        if (this.subIndex != subIndex) this.subIndex = subIndex;
                        series = getSeries(mainValue, subIndex, max: 1000);
                      });
                    },
                    mainValue: mainValue,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: BarChart(
                      Domain.getDomain(
                        ["Profit", "Loss"],
                        [R.C.kGreenColor, R.C.kRedColor],
                      ),
                      series,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            BoxPanel(
              radius: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              padding: EdgeInsets.zero,
              child: FutureBuilder<List<Market>>(
                initialData: [],
                future: _store.fetchNomicsList(),
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.waiting &&
                      _store.topMarketLst.length == 0) {
                    return Column(
                      children: [
                        SizedBox(height: 10.0),
                        ...List.generate(10, (index) {
                          return Column(
                            children: [
                              PlaceHolderItem(),
                              Divider(),
                            ],
                          );
                        }),
                      ],
                    );
                  }
                  return Column(
                    children: _store.topMarketLst
                        .map((e) => Column(
                              children: [
                                CryptoItem(item: e),
                                Divider(),
                              ],
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dots(int current, index) {
    if (current != index) {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dotColor(index),
        ),
      );
    } else {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: dotColor(index),
        ),
      );
    }
  }

  Color dotColor(int index) {
    return _currentIndexUp == index
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onBackground;
  }

  Widget _buildAppBar() {
    return new AppBar(
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
              Helpers.getAvatar('boxerbuzz559@gmail.com'),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              height: 45,
              width: MediaQuery.of(context).size.width * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconWidget(
                    iconPath: R.I.icSearch,
                    color: AppTheme.getColor(context),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => GBNotifyScreen())),
                    child: IconWidget(
                      iconPath: R.I.icNotification,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      elevation: 0,
    );
  }

  navigateRoute(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GBOverview(),
      ),
    );
  }

  carouselSliderList(List<String> getImageSliderList) {
    return getImageSliderList.map((i) {
      return Builder(builder: (BuildContext context) {
        return imageSliderItem(i);
      });
    }).toList();
  }

  Widget imageSliderItem(String i) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          i,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<String> banners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];
}

class TopPairsItem extends StatelessWidget {
  final TopPair pair;

  TopPairsItem(this.pair);

  @override
  Widget build(BuildContext context) {
    final Helpers help = Helpers();
    return Padding(
      padding: EdgeInsets.all(1 / 2).add(EdgeInsets.only(left: 5.0)),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${pair.name}/USDT',
                    style: GoogleFonts.barlow(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '${!pair.change.isNegative ? '+' : ''} ${pair.change}',
                    style: GoogleFonts.barlow(
                      fontWeight: FontWeight.w600,
                      color: pair.change.isNegative
                          ? Colors.redAccent
                          : R.C.kGreenColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              TextTransition(
                text: '${help.fiatFormat(context, sym: '').format(pair.price)}',
                textStyle: GoogleFonts.barlow(
                  fontSize: 30.0,
                  letterSpacing: -.5,
                  fontWeight: FontWeight.w500,
                  color: pair.change.isNegative
                      ? Colors.redAccent.withOpacity(0.6)
                      : R.C.kGreenColor,
                ),
                align: TextAlign.left,
                duration: Duration(milliseconds: 400),
                width: 120,
              ),
              Text(
                '${help.fiatFormat(context, decimal: 2, sym: '\$ ').format(pair.price)}',
                style: GoogleFonts.barlow(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
