import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class GBTrade extends StatefulWidget {
  static Screen gmTrade = Screen(
    title: 'Trade',
    contentBuilder: (context) => GBTrade(),
  );

  @override
  _GBTradeState createState() => _GBTradeState();
}

class _GBTradeState extends State<GBTrade> {
  Widget build(BuildContext context) {
    final _store = Provider.of<SendProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '18644.27',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    '~ 18644 USD',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: 20.0,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        '+ 3.80 %',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              _build(context),
              SizedBox(height: 10.0),
              Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 10.0),
              CupertinoSlidingSegmentedControl(
                groupValue: _store.sType,
                children: {
                  'market': _SegmentItem(title: 'Market'),
                  'limit': _SegmentItem(title: 'Limit'),
                  'stop': _SegmentItem(title: 'Stop Limit'),
                },
                onValueChanged: (label)=> _store.updateType(label),
              ),
              Row(
                children: [
                  Expanded(child: Buy()),
                  SizedBox(width: 5.0),
                  Expanded(child: Sell()),
                ],
              ),
              SizedBox(height: 5.0),
              Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              buildCategoryBar(context),
              Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? 'assets/images/search_dark.svg'
                        : 'assets/images/search_light.svg',
                    height: 300,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCategoryBar(context) {
    return Container(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 0.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Open Order',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            width: 80.0,
            height: 32.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  blurRadius: 2.0,
                )
              ],
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(width: 12.0),
          Container(
            height: 32.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Text(
                'Trigger Order',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Expanded(child: Container()),
          IconWidget(iconPath: R.I.icMore)
        ],
      ),
    );
  }

  Widget buildBadge(int length) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    return new AppBar(
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            height: 45,
            width: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Text(
                  'BTC/USDT',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontSize: 15.0,
                      ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    height: 40,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: RotatedBox(
                      child: IconWidget(
                        iconPath: R.I.icRightArrow,
                        color: Colors.white,
                        padding: 12.0,
                      ),
                      quarterTurns: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5.0),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icChart,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  InkWell(
                    onTap: () => null,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icMore,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _build(context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Buy Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'Volume',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 5.0,
            color: Theme.of(context).colorScheme.background,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Sell Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'Volume',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  final String title;

  _SegmentItem({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
