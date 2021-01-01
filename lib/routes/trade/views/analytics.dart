import 'package:flutter/material.dart';

import '../../../exports.dart';

class AnalyticRow extends StatelessWidget {
  final String buy;
  final String change;
  final String volume;
  final String high;
  final String low;
  final String bTitle;
  final String cTitle;
  final String vTitle;
  final String hTitle;
  final String lTitle;

  AnalyticRow(
      {this.buy,
      this.change,
      this.volume,
      this.high,
      this.low,
      this.bTitle,
      this.cTitle,
      this.vTitle,
      this.hTitle,
      this.lTitle});
  @override
  Widget build(BuildContext context) {
    var sol = Theme.of(context).textTheme.overline.copyWith(letterSpacing: 0.5);
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bTitle ?? 'Best Buy:',
                style: sol.copyWith(fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              Text(
                cTitle ?? '24h Change:',
                style: sol.copyWith(fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              Text(
                vTitle ?? '24h Volume:',
                style: sol.copyWith(fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              Text(
                hTitle ?? '24h High:',
                style: sol.copyWith(fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              Text(
                lTitle ?? '24h Low:',
                style: sol.copyWith(fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$buy',
                  style: sol.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$change',
                  style: sol.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: R.C.kGreenColor,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$volume',
                  style: sol.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$high',
                  style: sol.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$low',
                  style: sol.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
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
