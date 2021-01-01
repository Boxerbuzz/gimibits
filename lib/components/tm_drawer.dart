import 'package:flutter/material.dart';

import '../exports.dart';

final menuScreenKey = new GlobalKey(debugLabel: 'MenuScreen');

class GBDrawer extends StatefulWidget {
  final Menu menu;
  final String selectedItemId;
  final Function(String) onMenuItemSelected;

  GBDrawer({
    this.menu,
    this.selectedItemId,
    this.onMenuItemSelected,
  }) : super(key: menuScreenKey);
  @override
  _GBDrawerState createState() => _GBDrawerState();
}

class _GBDrawerState extends State<GBDrawer> with TickerProviderStateMixin {
  AnimationController titleAnimationController;
  double selectorYTop;
  double selectorYBottom;

  setSelectedRenderBox(RenderBox newRenderBox) async {
    final newYTop = newRenderBox.localToGlobal(const Offset(0.0, 0.0)).dy;
    final newYBottom = newYTop + newRenderBox.size.height;
    if (newYTop != selectorYTop) {
      if (mounted) return;
      setState(() {
        selectorYTop = newYTop;
        selectorYBottom = newYBottom;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    titleAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  createMenuTitle(CtrlState ctrl) {
    switch (ctrl.state) {
      case MenuState.open:
      case MenuState.opening:
        titleAnimationController.forward();
        break;
      case MenuState.closed:
      case MenuState.closing:
        titleAnimationController.reverse();
        break;
    }

    return new AnimatedBuilder(
      animation: titleAnimationController,
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'GIMIBITS',
            style: new TextStyle(
              color: const Color(0x88444444),
              fontSize: 240.0,
            ),
            textAlign: TextAlign.left,
            softWrap: false,
          ),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return new Transform(
          transform: new Matrix4.translationValues(
            250.0 * (1.0 - titleAnimationController.value) - 100.0,
            0.0,
            0.0,
          ),
          child: child,
        );
      },
    );
  }

  createMenuItems(CtrlState ctrl) {
    final List<Widget> listItems = [];
    final animationIntervalDuration = 0.5;
    final lstDelay = ctrl.state != MenuState.closing ? 0.05 : 0.0;

    for (var i = 0; i < widget.menu.items.length; ++i) {
      final animationIntervalStart = i * lstDelay;
      final animationIntervalEnd =
          animationIntervalStart + animationIntervalDuration;
      final isSelected = widget.menu.items[i].id == widget.selectedItemId;

      listItems.add(
        new AnimatedMenuListItem(
          menuState: ctrl.state,
          isSelected: isSelected,
          duration: const Duration(milliseconds: 600),
          curve: Interval(
            animationIntervalStart,
            animationIntervalEnd,
            curve: Curves.easeOut,
          ),
          menuListItem: new _MenuListItem(
            title: widget.menu.items[i].title,
            isSelected: isSelected,
            icon: widget.menu.items[i].icon,
            hasBadgeIndicator: widget.menu.items[i].hasIndicator,
            onTap: () {
              widget.onMenuItemSelected(widget.menu.items[i].id);
              ctrl.close();
            },
          ),
        ),
      );
    }

    return new Transform(
      transform: new Matrix4.translationValues(
        0.0,
        225.0,
        0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuCtrl(
      builder: (BuildContext context, CtrlState menuController) {
        var shouldRenderSelector = true;
        var actualSelectorYTop = selectorYTop;
        var actualSelectorYBottom = selectorYBottom;
        var selectorOpacity = 1.0;

        if (menuController.state == MenuState.closed ||
            menuController.state == MenuState.closing ||
            selectorYTop == null) {
          final RenderBox menuScreenRenderBox =
              context.findRenderObject() as RenderBox;
          if (menuScreenRenderBox != null) {
            final menuScreenHeight = menuScreenRenderBox.size.height;
            actualSelectorYTop = menuScreenHeight - 50.0;
            actualSelectorYBottom = menuScreenHeight;
            selectorOpacity = 0.0;
          } else {
            shouldRenderSelector = false;
          }
        }

        return new Container(
          width: double.infinity,
          height: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/dark_grunge_bk.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(
              children: [
                createMenuTitle(menuController),
                createMenuItems(menuController),
                shouldRenderSelector
                    ? ItemSelector(
                        topY: actualSelectorYTop,
                        bottomY: actualSelectorYBottom,
                        opacity: selectorOpacity,
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemSelector extends ImplicitlyAnimatedWidget {
  final double topY;
  final double bottomY;
  final double opacity;

  ItemSelector({
    this.topY,
    this.bottomY,
    this.opacity,
  }) : super(duration: const Duration(milliseconds: 250));

  @override
  _ItemSelectorState createState() => new _ItemSelectorState();
}

class _ItemSelectorState extends AnimatedWidgetBaseState<ItemSelector> {
  Tween<double> _topY;
  Tween<double> _bottomY;
  Tween<double> _opacity;

  @override
  void forEachTween(TweenVisitor visitor) {
    _topY = visitor(
      _topY,
      widget.topY,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _bottomY = visitor(
      _bottomY,
      widget.bottomY,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _opacity = visitor(
      _opacity,
      widget.opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: _topY.evaluate(animation) + 20,
      child: new Opacity(
        opacity: _opacity.evaluate(animation),
        child: new Container(
          width: 5.0,
          height: _bottomY.evaluate(animation) - _topY.evaluate(animation),
          color: Colors.red,
        ),
      ),
    );
  }
}

class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {
  final _MenuListItem menuListItem;
  final MenuState menuState;
  final bool isSelected;
  final Duration duration;

  AnimatedMenuListItem({
    this.menuListItem,
    this.menuState,
    this.isSelected,
    this.duration,
    curve,
  }) : super(duration: duration, curve: curve);

  @override
  _AnimatedMenuListItemState createState() => new _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState
    extends AnimatedWidgetBaseState<AnimatedMenuListItem> {
  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;

  updateSelectedRenderBox() {
    final renderBox = context.findRenderObject() as RenderBox;
    if (renderBox != null && widget.isSelected) {
      (menuScreenKey.currentState as _GBDrawerState)
          .setSelectedRenderBox(renderBox);
    }
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    var slide, opacity;

    switch (widget.menuState) {
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;
        opacity = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
    }

    _translation = visitor(
      _translation,
      slide,
      (dynamic value) => new Tween<double>(begin: value),
    );

    _opacity = visitor(
      _opacity,
      opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateSelectedRenderBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Opacity(
          opacity: _opacity.evaluate(animation),
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0,
              _translation.evaluate(animation) + 0.1,
              0.0,
            ),
            child: widget.menuListItem,
          ),
        ),
      ],
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  final String icon;
  final bool hasBadgeIndicator;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap,
    this.icon,
    this.hasBadgeIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected ? null : onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: new Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: new Stack(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /*Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child:
                  ),*/
                  IconWidget(
                    iconPath: icon,
                    color: isSelected ? Colors.white : Colors.grey,
                    padding: 4.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    title,
                    style: new TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              hasBadgeIndicator
                  ? Positioned(
                      left: AppTheme.viewportWidth(context) * 0.08,
                      top: 5.0,
                      child: Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  : Offstage()
            ],
          ),
        ),
      ),
    );
  }
}

class Menu {
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}

class MenuItem {
  final String id;
  final String title;
  final String icon;
  final bool hasIndicator;

  MenuItem({
    this.id,
    this.title,
    this.icon,
    this.hasIndicator,
  });
}
