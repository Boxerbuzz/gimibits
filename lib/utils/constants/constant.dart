import 'package:flutter/material.dart';

import '../../exports.dart';

class R {
  static final S = _String();
  static final I = _Images();
  static final C = _Colors();
}

class _String {
  final String appName = '';
  final String coreValue = '';
  final String ngn = '₦';
  final String kLoremIpsum =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum curabitur. Arcu ac tortor dignissim convallis aenean et tortor.';
}

class _Images {
  static String iconPath(String icon) => 'assets/icons/$icon.svg';

  String get icAdd => iconPath('add');
  String get icAddCard => iconPath('add_card');
  String get icBank => iconPath('bank');
  String get icNotification => iconPath('bell');
  String get icCalendar => iconPath('calendar');
  String get icCard => iconPath('card');
  String get icChart => iconPath('chart');
  String get icChat => iconPath('chat');
  String get icContact => iconPath('contact');
  String get icCopy => iconPath('copy');
  String get icCheck => iconPath('check');
  String get icClose => iconPath('close');
  String get icDashboard => iconPath('dashboard');
  String get icDownTrend => iconPath('down_trend');
  String get icDownload => iconPath('download');
  String get icExclamation => iconPath('exclamation');
  String get icFutures => iconPath('future');
  String get icFlashOn => iconPath('flash_on');
  String get icFlashOff => iconPath('flash_off');
  String get icId => iconPath('curriculum');
  String get icSettings => iconPath('gear');
  String get icSupport => iconPath('headphones');
  String get icHome => iconPath('home');
  String get icForgetPass => iconPath('ic_forgot_pass');
  String get icBack => iconPath('left_arrow');
  String get icLock => iconPath('lock');
  String get icLogOut => iconPath('log_out');
  String get icMarket => iconPath('market');
  String get icMax => iconPath('maximize');
  String get icMenu => iconPath('menu');
  String get icMore => iconPath('more');
  String get icNews => iconPath('newspaper');
  String get icNote => iconPath('note');
  String get icUser => iconPath('profile');
  String get icReceive => iconPath('qr-code');
  String get icRefresh => iconPath('refresh');
  String get icForward => iconPath('right_arrow');
  String get icRightDown => iconPath('right_down');
  String get icRightUp => iconPath('right_up');
  String get icScan => iconPath('scan');
  String get icSearch => iconPath('search');
  String get icSend => iconPath('send');
  String get icShare => iconPath('share');
  String get icPhone => iconPath('smartphone');
  String get icStar => iconPath('star');
  String get icStocks => iconPath('stock_market');
  String get icSpot => iconPath('spot');
  String get icSubject => iconPath('subject');
  String get icSwitchCam => iconPath('switch_camera');
  String get icTag => iconPath('tag');
  String get icTransfer => iconPath('transfer');
  String get icTransfer1 => iconPath('transfer1');
  String get icUpDown => iconPath('up_down');
  String get icVerify => iconPath('verify');
  String get icWallet => iconPath('wallet');
  String get icWorld => iconPath('world');
  String get icRightArrow => iconPath('ic_arrow');
  String get icLeftArrow => iconPath('left_chevron');
  String get icLineChart => iconPath('line-chart');
}

class _Colors {
  final Color kTextColor = Color(0xFF151C2A);
  final Color kTextSecondaryColor = Color(0xFF7E8EAA);
  final Color kPrimaryColor = Color(0xFF5D92EB);
  final Color kGreenColor = Color(0xFF30C96B);
  final Color kRedColor = Color(0xFFEE6B8D);
  final Color kPurpleColor = Color(0xFFC482F9);
  final Color kBackgroundColor = Color(0xFFFBF8FF);
  final Color kLineColor = Color(0xFFEAEEF4);
  final Color kShadowColor1 = Color.fromRGBO(149, 190, 207, 0.50);
  final Color kShadowColor2 = Color(0xFFCFECF8);
  final Color kShadowColor3 = Color.fromRGBO(0, 0, 0, 0.10);
  final Color kShadowColor4 = Color.fromRGBO(207, 236, 248, 0.50);
  final Color kShadowColor5 = Color.fromRGBO(238, 226, 255, 0.70);
  final Color kInactiveChartColor = Color(0xFFEAECEF);
  final kTextMediumColor = Color(0xFF53627C);
}

final menu = Menu(
  items: [
    MenuItem(
      id: 'dashboard',
      title: 'Dashboard',
      icon: R.I.icDashboard,
      hasIndicator: false,
    ),
    MenuItem(
      id: 'market',
      title: 'Market',
      icon: R.I.icMarket,
      hasIndicator: true,
    ),
    MenuItem(
      id: 'trade',
      title: 'Trade',
      icon: R.I.icChart,
      hasIndicator: false,
    ),
    MenuItem(
      id: 'news',
      title: 'News',
      icon: R.I.icNews,
      hasIndicator: false,
    ),
    MenuItem(
      id: 'settings',
      title: 'Settings',
      icon: R.I.icSettings,
      hasIndicator: false,
    ),
    MenuItem(
      id: 'support',
      title: 'Support',
      icon: R.I.icSupport,
      hasIndicator: false,
    ),
    MenuItem(
      id: 'logout',
      title: 'LogOut',
      icon: R.I.icLogOut,
      hasIndicator: false,
    ),
  ],
);

List bottomItems() {
  return [
    {"icon": R.I.icHome, "label": "Home", "isIcon": true},
    {"icon": R.I.icMarket, "label": "Overview", "isIcon": true},
    {"icon": "", "label": "", "isIcon": false},
    {"icon": R.I.icChart, "label": "Trade", "isIcon": true},
    {"icon": R.I.icUser, "label": "Profile", "isIcon": true}
  ];
}

List<Widget> tabs() {
  return [
    Tab(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text('ORDER\'S'),
      ),
    ),
    Tab(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text('INFO'),
      ),
    ),
    Tab(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text('NEWS'),
      ),
    )
  ];
}

List<Widget> marketTabs(context) {
  List<Widget> tabs = [];
  tabs =
      'BTC,ETH,LTC,XPR,DASH,ETC,BCH,XMR,XLM,ZEC,EOS,TRX,BAT,ALGO,USDT,IOT,NEO,OMG,ZIL,ZRK'
          .split(',')
          .map((e) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Tab(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            e,
            style: GoogleFonts.barlow(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              letterSpacing: 2.0,
              color: AppTheme.getColor(context),
            ),
          ),
        ),
      ),
    );
  }).toList();
  return tabs;
}

Map<String, Widget> duration = {
  '1Hr': Text('Hour'),
  'Today': Text('Day'),
  'Week': Text('Week'),
  'Month': Text('Month'),
  'Year': Text('Year'),
};

Map<String, Widget> chartType = {
  'candle': Padding(
    padding: EdgeInsets.all(4.0),
    child: IconWidget(
      iconPath: R.I.icLineChart,
      padding: 0.5,
    ),
  ),
  'line': Padding(
    padding: EdgeInsets.all(4.0),
    child: IconWidget(
      iconPath: R.I.icChart,
      padding: 0.5,
    ),
  ),
};

Map<String, Widget> marketCategory = {
  'all': Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('All'),
      SizedBox(width: 5.0),
      IconWidget(
        iconPath: R.I.icTag,
        padding: 0.0,
        size: 20,
      ),
    ],
  ),
  'fav': Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Favourite'),
      SizedBox(width: 5.0),
      IconWidget(
        iconPath: R.I.icStar,
        padding: 0.0,
        size: 20,
      ),
    ],
  ),
  'futures': Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Futures'),
      SizedBox(width: 5.0),
      IconWidget(
        iconPath: R.I.icFutures,
        padding: 0.0,
        size: 20,
      ),
    ],
  ),
  'spot': Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Spot'),
      SizedBox(width: 5.0),
      IconWidget(
        iconPath: R.I.icSpot,
        padding: 0.0,
        size: 20,
      ),
    ],
  ),
};

final Map<String, String> assetsImage = {
  'BTC':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg',
  'ETH':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg',
  'USDT':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/usdt.svg',
  'BCH':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/bch.svg',
  'LTC':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/ltc.svg',
  'EOS':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eos.svg',
  'XMR':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/xmr.svg',
  'TRX':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/TRX.svg',
  'XML':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/xlm.svg',
  'DASH':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/dash.svg',
  'ETC':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/etc.svg',
  'ZEC':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/zec.svg',
  'BAT':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/bat.svg',
  'ALGO':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/ALGO.png',
  'XPR':
  'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/XPR.png',
};

String getAssetLogoUrl(String symbol) {
  var val = assetsImage.entries.where((element) => element.key == symbol);
  return val.first.value;
}

String getCurrency(String symbol) {
  if (symbol == 'ngn') return '${R.S.ngn}';
  return '\$';
}

List<Map<String, String>> splashData = [
  {
    "text":
    "Securely purchase and trade your favourite crypto currencies seamlessly",
    "image": "assets/images/2.svg",
    "head": "Purchase and trade",
  },
  {
    "text":
    "All activities and cryptographically encrypted end to end for your maximum safety",
    "image": "assets/images/3.svg",
    "head": "Totally secure",
  },
  {
    "text":
    "Fund your fiat wallets instantly within seconds using any debit card",
    "image": "assets/images/4.svg",
    "head": "Bank Funding",
  },
  {
    "text": "Securely receive and store your crypto assets without hassle",
    "image": "assets/images/1.svg",
    "head": "Secure store",
  },
  {
    "text":
    "Quickly make transfers and receive crypto assets securely and fast",
    "image": "assets/images/5.svg",
    "head": "Transfer crypto assets",
  },
];

List<double> mockChart = [
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
];

String curr = 'BTC,DASH,EOS,ETH,IOT,LTC,NEO,OMG,XLM,XMR,XPR,ZEC,ZIL,ZRK';

List<Map<String, dynamic>> cardDetails() {
  return [
    {
      "id": "3",
      "bank": "Zenith Bank",
      "class": "visa",
      "type": "debit",
      "number": "1234  5678  1234  5678",
      "color": 4278238420,
      "image": "circles",
      "balance": "€ 32 987",
      "transactions": [
        {"m": "Hilton Hotel", "t": "10:13 PM", "a": "-\$173", "i": "hotel"},
        {"m": "Ikea", "t": "1:30 PM", "a": "-\$328", "i": "home"}
      ]
    },
    {
      "id": "4",
      "bank": "Eco Bank",
      "class": "mastercard",
      "type": "credit",
      "number": "1234  5678  1234  5678",
      "color": 4294951175,
      "image": "layers",
      "balance": "\$ 1 007",
      "transactions": [
        {
          "m": "Roland Garros Store",
          "t": "8:24 PM",
          "a": "-\$114",
          "i": "tennis"
        },
        {"m": "Taxi", "t": "8:00 PM", "a": "-\$12", "i": "car"},
        {"m": "Dentist", "t": "2:15 PM", "a": "-\$32", "i": "toothOutline"}
      ]
    }
  ];
}
