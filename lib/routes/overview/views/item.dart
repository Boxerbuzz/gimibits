import 'package:flutter/material.dart';

import '../../../exports.dart';

class OverViewItem extends StatelessWidget {
  final CryptoAsset item;

  final double width;

  OverViewItem({this.item, this.width});
  @override
  Widget build(BuildContext context) {
    double priceChange = double.parse(item.increase ?? 0.0);
    double percentageChange = double.parse(item.pctIncrease ?? 0.0);
    return BoxPanel(
      width: width ?? AppTheme.viewportWidth(context) * 0.8,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 5.0,
            color: AppTheme.getAssetColor(item.code),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: item.isSvg == true
                            ? SvgPicture.network(item.image)
                            : Image.network(item.image),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          item.code,
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      child: IconWidget(iconPath: R.I.icCopy),
                      onTap: () {},
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.address}',
                      style: Theme.of(context).textTheme.overline,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${item.amount} ${item.code}',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$ ${item.value}',
                      style: Theme.of(context).textTheme.overline.copyWith(
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '\$ $priceChange ($percentageChange % )',
                      style: Theme.of(context).textTheme.overline.copyWith(
                            letterSpacing: 0.0,
                            color: priceChange.isNegative
                                ? R.C.kRedColor
                                : R.C.kGreenColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
