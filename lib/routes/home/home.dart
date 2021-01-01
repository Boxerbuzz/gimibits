import 'package:flutter/material.dart';
import '../../exports.dart';

class HomeGB extends StatefulWidget {
  @override
  _HomeGBState createState() => _HomeGBState();
}

class _HomeGBState extends State<HomeGB> {
  var selectedMenuItemId = 'dashboard';
  var activeScreen = GBDashboard.gmDashboard;

  @override
  Widget build(BuildContext context) {
    return GBScaffold(
      menuScreen: GBDrawer(
        menu: menu,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'dashboard') {
            setState(() => activeScreen = GBDashboard.gmDashboard);
          } else if (itemId == 'market') {
            setState(() => activeScreen = GBMarket.gmMarket);
          } else if (itemId == 'trade') {
            setState(() => activeScreen = GBTrade.gmTrade);
          } else if (itemId == 'news') {
            setState(() => activeScreen = GBNews.gmNews);
          } else if (itemId == 'settings') {
            setState(() => activeScreen = GBSettings.gmSettings);
          } else if (itemId == 'support') {
            setState(() => activeScreen = GBSupport.gmSupport);
          } else if (itemId == 'logout') {
            print('logout');
          }
        },
      ),
      contentScreen: activeScreen,
    );
  }
}
