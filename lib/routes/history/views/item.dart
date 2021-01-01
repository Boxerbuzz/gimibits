import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gimibits/exports.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  HistoryItem({this.history});
  @override
  Widget build(BuildContext context) {
    //var tt = Theme.of(context).textTheme.overline;
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(),
            ],
          ),
          Divider(height: 0.5),
        ],
      ),
    );
  }
}

Color getTransactionMode(String c) {
  if (c == 'D') return R.C.kGreenColor;
  return R.C.kRedColor;
}
