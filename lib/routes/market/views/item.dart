import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class CryptoItem extends StatelessWidget {
  final Market item;

  CryptoItem({this.item});

  @override
  Widget build(BuildContext context) {
    double priceChange = double.parse(item.meta['price_change'] ?? 0.0);
    double pctChange = double.parse(item.meta['price_change_pct'] ?? 0.0);
    final _store = Provider.of<MainProvider>(context);
    final helper = Helpers();
    return BoxPanel(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
      padding: EdgeInsets.zero.add(EdgeInsets.symmetric(horizontal: 10.0)),
      radius: 10.0,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
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
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  height: 35.0,
                  width: 100,
                  child: FutureBuilder<List<double>>(
                    future: _store.fetchNomicsChart(item.code),
                    initialData: mockChart,
                    builder: (ctx, data) {
                      if (data.connectionState == ConnectionState.active)
                        return Container();
                      final List<double> lst = data.data ?? [];
                      return MiniChart(
                        color: AppTheme.getAssetColor('${item.code}'),
                        spots: lst,
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 30.0,
                child: TextTransition(
                  text:
                  '${helper.fiatFormat(context).format(double.parse(item.price))}',
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  duration: Duration(milliseconds: 400),
                  width: 120,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$pctChange % (${helper.fiatFormat(context).format(priceChange ?? 00.00)})',
                    style: Theme.of(context).textTheme.overline.copyWith(
                          color: priceChange.isNegative
                              ? R.C.kRedColor
                              : R.C.kGreenColor,
                          letterSpacing: 0.0,
                        ),
                  ),
                  IconWidget(
                    iconPath: priceChange.isNegative
                        ? R.I.icRightDown
                        : R.I.icRightUp,
                    size: 10.0,
                    padding: 4.0,
                    color: priceChange.isNegative
                        ? R.C.kRedColor
                        : R.C.kGreenColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  navigateRoute(context) {}
}

class PlaceHolderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var r = Random();
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          SizedBox(width: 5.0),
          Shimmer.fromColors(
            baseColor: R.C.kShadowColor1,
            highlightColor: R.C.kShadowColor4,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: PlaceholderImage(
                height: 45,
                width: 45,
                cornerRadius: 8,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Shimmer.fromColors(
                baseColor: R.C.kShadowColor1,
                highlightColor: R.C.kShadowColor2,
                child: Container(
                  height: 15,
                  width: 90.0 + r.nextInt(40),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: R.C.kShadowColor1,
                highlightColor: R.C.kShadowColor2,
                child: Container(
                  height: 15,
                  width: 50.0 + r.nextInt(30),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Shimmer.fromColors(
                baseColor: R.C.kShadowColor1,
                highlightColor: R.C.kShadowColor2,
                child: ClipRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: 30.0,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2),
              Shimmer.fromColors(
                baseColor: R.C.kShadowColor1,
                highlightColor: R.C.kShadowColor2,
                child: Container(
                  height: 10,
                  width: 85.0 + r.nextInt(30),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 2),
              Shimmer.fromColors(
                baseColor: R.C.kShadowColor1,
                highlightColor: R.C.kShadowColor2,
                child: Container(
                  height: 10,
                  width: 130.0 + r.nextInt(30),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PairItem extends StatelessWidget {
  final PairInfo pair;
  PairItem({this.pair});
  @override
  Widget build(BuildContext context) {
    Helpers help = Helpers();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pair.exchange.baseAsset,
                      style: GoogleFonts.barlow(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      ' / ${pair.exchange.quoteAsset}',
                      style: GoogleFonts.barlow(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.getColor(context).withOpacity(0.4)),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      '24H ',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${help.fiatFormat(context, sym: '').format(double.parse(pair.pair.volume))}',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${double.parse(pair.pair.lastPrice)}',
                  style: GoogleFonts.barlow(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${double.parse(pair.pair.priceChange).isNegative ? '' : '+'} ${pair.pair.priceChange}',
                  style: GoogleFonts.barlow(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: double.parse(pair.pair.priceChange).isNegative
                        ? R.C.kRedColor
                        : R.C.kGreenColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: double.parse(pair.pair.priceChangePercent).isNegative
                  ? R.C.kRedColor
                  : Colors.green.shade700,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                '${double.parse(pair.pair.priceChangePercent).isNegative ? '' : '+'} ${pair.pair.priceChangePercent}%',
                style: GoogleFonts.barlow(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
