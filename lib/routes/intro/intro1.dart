import 'package:flutter/material.dart';

import '../../exports.dart';
import 'views/smooth_indicator.dart';

class GBIntro1 extends StatefulWidget {
  @override
  _GBIntro1State createState() => _GBIntro1State();
}

class _GBIntro1State extends State<GBIntro1> {
  PageController ctrl;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    ctrl = PageController(initialPage: _index, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Positioned(
                left: 24,
                top: 56,
                child: Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: IconWidget(
                        iconPath: R.I.icClose,
                        padding: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'GIMIBIT\'S',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SmoothPageIndicator(
                      controller: ctrl,
                      count: Intro.lstIntro.length,
                      effect: WormEffect(
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Container(
                  height: AppTheme.viewportHeight(context) * 1.0,
                  child: PageView.builder(
                    controller: ctrl,
                    physics: BouncingScrollPhysics(),
                    pageSnapping: true,
                    itemCount: Intro.lstIntro.length,
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        SizedBox(height: 30.0),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            Intro.lstIntro[index].image,
                            height: 400,
                          ),
                        ),
                      ],
                    ),
                    onPageChanged: (val) => setState(() => _index = val),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 410,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Intro {
  final Color color;
  final String image;
  final String title;
  final String desc;

  Intro({this.color, this.image, this.desc, this.title});

  static List<Intro> lstIntro = [
    Intro(
      color: Colors.indigo,
      image: 'assets/images/2.svg',
      title: 'Purchase and trade',
      desc:
          'Securely purchase and trade your favourite crypto currencies seamlessly',
    ),
    Intro(
      color: Colors.amber,
      image: 'assets/images/3.svg',
      title: 'Totally secure',
      desc:
          'All activities and cryptographically encrypted end to end for your maximum safety',
    ),
    Intro(
      color: Colors.teal,
      image: 'assets/images/4.svg',
      title: 'Bank Funding',
      desc:
          'Fund your fiat wallets instantly within seconds using any debit card',
    ),
    Intro(
      color: Colors.blueAccent,
      image: 'assets/images/1.svg',
      title: 'Secure store',
      desc: 'Securely receive and store your crypto assets without hassle',
    ),
    Intro(
      color: Colors.green,
      image: 'assets/images/5.svg',
      title: 'Transfer crypto assets',
      desc:
          'Quickly make transfers and receive crypto assets securely and fast',
    ),
  ];
}
