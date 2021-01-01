import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../exports.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> with FormMixin {
  ValueNotifier<String> amount;

  @override
  Widget build(BuildContext context) {
    var sol = Theme.of(context).textTheme.overline.copyWith(letterSpacing: 0.5);
    final _store = Provider.of<SendProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
          helper: 'Buy price',
          label: 'Buy price',
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
              '\$ 6,421.2 USDT',
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
          color: R.C.kGreenColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Buy',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onItemChange(String name, String value) {}

  @override
  void onItemValidate(String name, bool isValid, {String value}) {}
}
