import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../exports.dart';

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> with FormMixin {
  ValueNotifier<String> amount;

  @override
  Widget build(BuildContext context) {
    var sol = Theme.of(context).textTheme.overline.copyWith(letterSpacing: 0.5);
    final _store = Provider.of<SendProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        _store.type == TradeType.StopOrder
            ? TextInput(
                key: ValueKey('stop'),
                onValidate: onItemValidate,
                onChange: onItemChange,
                initialValue: '',
                type: InputType.number,
                isActive: true,
                helper: 'Trigger price',
                label: 'Trigger price',
                isRequired: true,
                valueNotifier: amount,
              )
            : SizedBox.shrink(),
        _store.type == TradeType.LimitOrder ||
                _store.type == TradeType.StopOrder
            ? TextInput(
                key: ValueKey('limit'),
                onValidate: onItemValidate,
                onChange: onItemChange,
                initialValue: '',
                type: InputType.number,
                isActive: true,
                helper: 'Limit price',
                label: 'Limit price',
                isRequired: true,
                valueNotifier: amount,
              )
            : SizedBox.shrink(),
        TextInput(
          key: ValueKey('amount'),
          onValidate: onItemValidate,
          onChange: onItemChange,
          initialValue: '',
          type: InputType.number,
          isActive: true,
          helper: 'Sell price',
          label: 'Sell price',
          isRequired: true,
          valueNotifier: amount,
        ),
        OptionPct(),
        SizedBox(height: 5.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available',
              style: sol.copyWith(fontSize: 14.0),
            ),
            Expanded(child: Container()),
            Text(
              '\$ 0.0456 BTC',
              style: sol.copyWith(fontSize: 14.0),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        FlatButton(
          onPressed: () {},
          disabledColor: R.C.kInactiveChartColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          color: R.C.kRedColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sell',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void onItemChange(String name, String value) {}

  @override
  void onItemValidate(String name, bool isValid, {String value}) {}
}

class OptionPct extends StatelessWidget {
  final String title;

  OptionPct({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem('25%'),
          Container(
            height: 30,
            width: 1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          _buildItem('50%'),
          Container(
            height: 30,
            width: 1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          _buildItem('75%'),
          Container(
            height: 30,
            width: 1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          _buildItem('100%'),
        ],
      ),
    );
  }

  _buildItem(title) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          //border: Border.all(width: 0.5, color: Colors.grey),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title),
        ],
      ),
    ).ripple(onTap: () {});
  }
}
