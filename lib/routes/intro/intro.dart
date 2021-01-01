import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';
import 'views/smooth_indicator.dart';

class GBIntro extends StatefulWidget {
  @override
  _GBIntroState createState() => _GBIntroState();
}

class _GBIntroState extends State<GBIntro> {
  int currentPage = 0;
  PageController _ctrl = PageController(
    viewportFraction: 1.1,
    keepPage: true,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(top: 50.0),
            child: Row(
              children: [
                Expanded(child: Container()),
                CupertinoButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: GoogleFonts.quicksand(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              pageSnapping: true,
              controller: _ctrl,
              onPageChanged: (value) => setState(() => currentPage = value),
              itemCount: splashData.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 240,
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360.0),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.4),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              splashData[index]["image"],
                              height: 290.0,
                              width: 290.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(height: 10.0),*/
                    Container(
                      child: SmoothPageIndicator(
                        controller: _ctrl,
                        count: splashData.length,
                        effect: WormEffect(
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      splashData[currentPage]['head'],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      splashData[currentPage]['text'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(flex: 2),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            text: "GET STARTED",
                            press: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              navigateRoute(GBLogin(), context, pop: true);
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

const kAnimationDuration = Duration(milliseconds: 200);
