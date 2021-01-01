import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class GBOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _ctrl = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.9,
    );
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: BoxPanel(
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: IconWidget(iconPath: R.I.icWallet, size: 30.0),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Portfolio Balance',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '\$ 2,706,599.31',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '+ \$ 162,395.9 (+ 6 %)',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: R.C.kGreenColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    CommonIconButton(
                      icon: IconWidget(
                        iconPath: 'assets/icons/ic_arrow.svg',
                        size: 24.0,
                        padding: 3.0,
                      ),
                      btnColor: Theme.of(context).colorScheme.background,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GBAnalytics(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: AppTheme.viewportHeight(context) * 0.2,
              width: double.infinity,
              child: PageView(
                controller: _ctrl,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {},
                children: [
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index == 4 ? 0.0 : 10.0),
                      child: OverViewItem(item: CryptoAsset.assets[index]),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineCircleButton(
                  icon: R.I.icSend,
                  title: 'Send',
                  onTap: () => navigateRoute(SendAsset(), context),
                ),
                OutlineCircleButton(
                  icon: R.I.icScan,
                  title: 'Scan',
                  onTap: () => navigateRoute(ScanBarCode(), context),
                ),
                OutlineCircleButton(
                  icon: R.I.icReceive,
                  title: 'Receive',
                  onTap: () => navigateRoute(ReceiveAssets(), context),
                ),
                OutlineCircleButton(
                  icon: R.I.icDownload,
                  title: 'Request',
                  onTap: () => navigateRoute(RequestAssets(), context),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: AppTheme.primaryGradient(context),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Container(
                      height: 25.0,
                      width: 115.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Center(
                        child: Text(
                          'Transactions',
                          style: Theme.of(context).textTheme.overline.copyWith(
                                fontSize: 14.0,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/images/no_data_light.svg'
                  : 'assets/images/no_data_dark.svg',
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    return new AppBar(
      title: Row(
        children: <Widget>[
          Text(
            'Overview',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
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
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GBChat(),
                      ),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icChat,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GBNotifyScreen(),
                      ),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icNotification,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      elevation: 0,
    );
  }
}

class OutlineCircleButton extends StatelessWidget {
  final String icon;
  final String title;
  final onTap;
  OutlineCircleButton({this.icon, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65.0,
          width: 65.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            gradient: AppTheme.primaryGradient(context),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Theme.of(context).colorScheme.background,
              ),
              child: IconWidget(iconPath: icon, size: 20.0),
            ),
          ),
        ).ripple(onTap: onTap, bR: BorderRadius.circular(60)),
        Text(
          title,
          style: Theme.of(context).textTheme.overline,
        ),
      ],
    );
  }
}
