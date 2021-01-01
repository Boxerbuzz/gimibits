import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

typedef Widget BaseScaffoldBuilder(BuildContext ctx, CtrlState menuCtrl);

class GBScaffold extends StatefulWidget {
  final Widget menuScreen;
  final Screen contentScreen;

  GBScaffold({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _GBScaffoldState createState() => new _GBScaffoldState();
}

class _GBScaffoldState extends State<GBScaffold> with TickerProviderStateMixin {
  CtrlState menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    menuController = new CtrlState(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  createContentDisplay() {
    return zoomAndSlideContent(
      new Scaffold(
        appBar: _AppBar(
          title: widget.contentScreen.title,
          onPressed: () => menuController.toggle(),
          icon: menuController.state == MenuState.closed
              ? R.I.icMenu
              : R.I.icBack,
        ),
        body: widget.contentScreen.contentBuilder(context),
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount = 230.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 15.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.menuScreen,
        createContentDisplay(),
      ],
    );
  }
}

class MenuCtrl extends StatefulWidget {
  final BaseScaffoldBuilder builder;

  MenuCtrl({
    this.builder,
  });

  @override
  MenuCtrlState createState() => MenuCtrlState();
}

class MenuCtrlState extends State<MenuCtrl> {
  CtrlState menuController;

  @override
  void initState() {
    super.initState();

    menuController = getMenuController(context);
    menuController.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    final scaffoldState = context.findAncestorStateOfType<_GBScaffoldState>();
    return scaffoldState.menuController;
  }

  _onMenuControllerChange() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, getMenuController(context));
  }
}

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
  });
}

class CtrlState extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  CtrlState({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final _onPressed;
  final String _icon;

  _AppBar({
    @required String title,
    onPressed,
    String icon,
    Key key,
  })  : _title = title,
        _onPressed = onPressed,
        _icon = icon,
        super(key: key);

  static const appBarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: appBarSize,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: <Widget>[
            SizedBox(width: 5.0),
            CommonIconButton(
              icon: SvgPicture.asset(
                _icon,
                color: AppTheme.getColor(context),
                height: 20.0,
                width: 20.0,
              ),
              onTap: _onPressed,
              btnColor: Theme.of(context).colorScheme.background,
            ),
            SizedBox(width: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    Helpers.getAvatar('boxerbuzz559@gmail.com'),
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            SizedBox(width: 15.0),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);
}