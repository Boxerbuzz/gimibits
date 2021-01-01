import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/routes/overview/views/mini_chart.dart' as chart;

import '../../exports.dart';
import 'views/weekly_chart.dart';

class GBAnalytics extends StatefulWidget {
  @override
  _GBAnalyticsState createState() => _GBAnalyticsState();
}

class _GBAnalyticsState extends State<GBAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTitleWithIcon(),
                    SizedBox(height: 15),
                    buildCaseNum(context),
                    SizedBox(height: 15),
                    WeeklyChart(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildTextWithPct(
                          context,
                          pct: "6.43",
                          title: "From Last Week",
                        ),
                        buildTextWithPct(
                          context,
                          pct: "9.43",
                          title: "R.O.I",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceAround,
                children: <Widget>[
                  ChartCard(
                    title: 'ROI',
                    amount: 1043,
                    iconColor: Colors.green,
                    press: () {},
                  ),
                  ChartCard(
                    title: 'Bonus',
                    amount: 8145,
                    iconColor: Colors.green,
                    press: () {},
                  ),
                  ChartCard(
                    title: 'Loan',
                    amount: -5050,
                    iconColor: Colors.green,
                    press: () {},
                  ),
                  ChartCard(
                    title: 'Savings',
                    amount: 9300,
                    iconColor: Colors.green,
                    press: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RichText buildTextWithPct(context, {title, pct}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$pct% \n",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: AppTheme.getColor(context),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Row buildCaseNum(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "547 ",
          style: Theme.of(context).textTheme.headline2.copyWith(
            color: Theme.of(context).colorScheme.primary,
            height: 1.2,
          ),
        ),
        Text(
          "5.9% ",
          style: TextStyle(color: R.C.kGreenColor),
        ),
        IconWidget(
          iconPath: "assets/icons/right_up.svg",
          size: 10.0,
          padding: 2.0,
          color: R.C.kGreenColor,
        ),
      ],
    );
  }

  Row buildTitleWithIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Investment",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        IconWidget(
          iconPath: "assets/icons/more.svg",
          size: 20.0,
          padding: 0.0,
        ),
      ],
    );
  }

  Widget _buildAppBar(context) {
    return new AppBar(
      elevation: 0,
      leading: CupertinoButton(
        child: IconWidget(
          iconPath: R.I.icBack,
          padding: 0.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: <Widget>[
          Text(
            'Analytics',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
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
                  IconWidget(
                    iconPath: R.I.icNews,
                    color: AppTheme.getColor(context),
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
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final int amount;
  final Color iconColor;
  final Function press;
  const ChartCard({
    Key key,
    this.title,
    this.amount,
    this.iconColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var tt = Theme.of(context).textTheme;
    Helpers help = Helpers();
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 5,
            // Here constraints.maxWidth provide us the available width for the widget
            // And then divide the available space by two, minus 5 from the result allowing for padding
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        // wrapped within an expanded widget to allow for small density device
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: iconColor.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(child: Container()),
                        SizedBox(width: 5),
                        Text(
                          '5.89 %',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$title\n",
                                style: GoogleFonts.barlow(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.getColor(context),
                                  height: 0.9,
                                ),
                              ),
                              Text(
                                "${help.fiatFormat(context, sym: '\$ ').format(amount)}\n",
                                style: GoogleFonts.barlow(
                                  fontWeight: FontWeight.w500,
                                  color: amount.isNegative ? R.C.kRedColor : R.C.kGreenColor,
                                  height: 0.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: chart.MiniChart(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
