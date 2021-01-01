import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [
          GBDashboard(),
          GBOverview(),
          Container(),
          GBTrade(),
          GBProfile(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomItems().length,
              (index) {
                return bottomItems()[index]['isIcon']
                    ? InkWell(
                        onTap: () => selectedTab(index),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconWidget(
                                iconPath: bottomItems()[index]['icon'],
                                padding: 0.0,
                                color: index == pageIndex
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: Text(
                                  bottomItems()[index]['label'],
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GBMarket(),
                          ),
                        ),
                        child: CenterIcon(),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
