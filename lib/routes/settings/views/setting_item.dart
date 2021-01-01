import 'package:flutter/material.dart';

import '../../../exports.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final Function onTap;
  final bool bg;
  final Color color;
  SettingItem(
      {this.icon,
      this.title,
      this.subTitle,
      this.onTap,
      this.color,
      this.bg = false});

  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: bg == true ? color.withOpacity(0.5) :null,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.05),
              child: IconWidget(iconPath: icon),
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          IconWidget(
            iconPath: R.I.icRightArrow,
            padding: 0.0,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
        ],
      ),
    ).ripple(onTap: onTap);
  }
}
