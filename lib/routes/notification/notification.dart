import 'package:flutter/material.dart';

import '../../exports.dart';

class GBNotifyScreen extends StatefulWidget {
  @override
  _GBNotifyScreenState createState() => _GBNotifyScreenState();
}

class _GBNotifyScreenState extends State<GBNotifyScreen> {
  double _listPadding = 20;
  NotifyData _selectedNotification;
  ScrollController _scrollController = ScrollController();
  List<NotifyData> _notifications;

  @override
  void initState() {
    _notifications = NotifyData.notifications;
    super.initState();
  }

  Widget _buildListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _listPadding / 3,
        horizontal: _listPadding,
      ),
      child: NotificationCard(
        notifyData: _notifications[index],
        isOpen: _notifications[index] == _selectedNotification,
        onTap: _handleItemTapped,
      ),
    );
  }

  void _handleItemTapped(NotifyData data) {
    setState(() {
      if (_selectedNotification == data) {
        _selectedNotification = null;
      } else {
        _selectedNotification = data;
        var selectedIndex = _notifications.indexOf(_selectedNotification);
        var closedHeight = 70;
        var offset =
            selectedIndex * (closedHeight + _listPadding) - closedHeight * .35;
        _scrollController.animateTo(
          offset,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: 40),
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/images/notify_dark.svg'
                  : 'assets/images/notify_light.svg',
              height: 300,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonIconButton(
                    icon: IconWidget(
                      iconPath: R.I.icBack,
                      padding: 2.0,
                    ),
                    btnColor: Theme.of(context).colorScheme.onBackground,
                    onTap: ()=> Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'New\nNotifications',
                    style: GoogleFonts.barlow(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      height: 0.9,
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(
                      color: R.C.kGreenColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '5',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
                _notifications.length, (index) => _buildListItem(index)),
          ],
        ),
      ),
    );
  }
}

///
/// Notification Items
///
class NotificationCard extends StatefulWidget {
  final Function(NotifyData) onTap;

  final bool isOpen;
  final NotifyData notifyData;

  const NotificationCard(
      {Key key, this.notifyData, this.onTap, this.isOpen = false})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard>
    with TickerProviderStateMixin {
  bool _wasOpen;

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen != _wasOpen) {
      _wasOpen = widget.isOpen;
    }

    var text = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        curve: !_wasOpen ? ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: widget.isOpen ? AppTheme.viewportHeight(context) * 0.17 : 65.0,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    CommonIconButton(
                      icon: IconWidget(
                        iconPath: R.I.icNotification,
                        padding: 0.0,
                        color: Colors.white,
                      ),
                      btnColor: Theme.of(context).colorScheme.primaryVariant,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.notifyData.title,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(
                              milliseconds: widget.isOpen ? 1000 : 500,
                            ),
                            switchInCurve: Curves.elasticOut,
                            switchOutCurve: ElasticOutCurve(.9),
                            layoutBuilder: (child, listChild) {
                              return !widget.isOpen
                                  ? Text(
                                      R.S.kLoremIpsum,
                                      style: text.overline,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          R.S.kLoremIpsum,
                                          style: text.overline,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        OutlineButton(
                                          onPressed: () {},
                                          child: Text(
                                            'More',
                                            style: TextStyle(
                                              color: AppTheme.getColor(context),
                                            ),
                                          ),
                                          color: color.primary,
                                          textColor: Colors.black54,
                                          borderSide: BorderSide(
                                            color: color.primary,
                                          ),
                                        )
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    CommonIconButton(
                      icon: RotatedBox(
                        child: IconWidget(
                          iconPath: 'assets/icons/ic_arrow.svg',
                          padding: 5.0,
                        ),
                        quarterTurns: 5,
                      ),
                      onTap: () => _handleTap(),
                      btnColor: Theme.of(context).colorScheme.background,
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap(widget.notifyData);
    }
  }
}

class NotifyData {
  final String title;
  final String desc;
  final String icon;

  NotifyData(this.title, this.desc, this.icon);

  static List<NotifyData> notifications = [
    NotifyData("Sent", '', 'up-arrow'),
    NotifyData("Received", '', 'down-arrow'),
    NotifyData("Transfer", '', 'transfer1'),
    NotifyData("Withdrawal", '', 'future'),
    NotifyData("Trade", '', 'chart'),
  ];
}
