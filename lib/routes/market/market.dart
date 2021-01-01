import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';

class GBMarket extends StatefulWidget {
  static Screen gmMarket = Screen(
    title: 'Market',
    contentBuilder: (context) => GBMarket(),
  );

  @override
  _GBMarketState createState() => _GBMarketState();
}

class _GBMarketState extends State<GBMarket>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 20, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: _buildTopAppBar(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool inner) {
          return <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: <Widget>[
                      _buildCategoryBar(),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverHeader(
                _buildSubCategoryBar(inner),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: FutureBuilder(
            future: _store.fetchExchangeList(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: _store.pairs.length > 10
                      ? _store.pairs.map((e) {
                          return Column(
                            children: [
                              PairItem(pair: e),
                              Divider(),
                            ],
                          );
                        }).take(30).toList()
                      : _store.pairs.map((e) {
                          return Column(
                            children: [
                              PairItem(pair: e),
                              Divider(color: Theme.of(context).colorScheme.onSurface),
                            ],
                          );
                        }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return new AppBar(
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
            'Market',
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
                    iconPath: R.I.icSearch,
                    color: AppTheme.getColor(context),
                  ),
                  Container(
                    height: 40,
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconWidget(
                    iconPath: R.I.icNotification,
                    color: AppTheme.getColor(context),
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

  Widget _buildCategoryBar() {
    return Container(
      height: 50,
      width: double.infinity,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl(
          children: marketCategory,
          groupValue: 'fav',
          onValueChanged: (val) {},
          thumbColor: Theme.of(context).colorScheme.primaryVariant,
        ),
      ),
    );
  }

  Widget _buildSubCategoryBar(bool inner) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inner == true ? Divider(color: Colors.white) : SizedBox.shrink(),
          Center(
            child: SizedBox(
              height: 20.0,
              child: TabBar(
                controller: _tabController,
                tabs: marketTabs(context),
                labelPadding: EdgeInsets.all(0.0),
                labelStyle: GoogleFonts.barlow(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                  color: AppTheme.getColor(context),
                ),
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                indicatorColor: Colors.grey.shade600,
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoTabs extends StatelessWidget {
  const InfoTabs({
    Key key,
    @required TabController tabController,
    @required List<Widget> tabs,
  })  : _tabController = tabController,
        _tabs = tabs,
        super(key: key);

  final TabController _tabController;
  final List<Widget> _tabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: _tabs,
          labelPadding: EdgeInsets.all(0.0),
          labelColor: Theme.of(context).colorScheme.background,
          labelStyle: TextStyle(letterSpacing: 3.0),
          indicatorColor: Colors.grey.shade600,
          indicatorWeight: 2.0,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildInfo(
                context,
                heading: 'Name',
                intro: 'Introduction',
                subHeading: 'Formation',
                desc: 'Description',
              ),
              _buildInfo(
                context,
                heading: 'History of Name',
                intro: 'Intro',
                subHeading: 'Details',
                desc: 'Desc',
              ),
              GridView.builder(
                itemCount: 10,
                padding: EdgeInsets.all(20.0),
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey,
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  ListView _buildInfo(BuildContext context,
      {String heading, String subHeading, String intro, String desc}) {
    return ListView(
      padding: EdgeInsets.all(25.0),
      primary: false,
      children: <Widget>[],
    );
  }
}

class SliverHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  SliverHeader(this.child);
  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        child,
      ],
    );
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}