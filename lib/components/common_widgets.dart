import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

class CommonIconButton extends StatelessWidget {
  final icon;
  final Color color;
  final Color btnColor;
  final Function onTap;

  CommonIconButton({this.icon, this.color, this.btnColor, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: btnColor == null ? Colors.white : btnColor,
      ),
      child: icon is Widget
          ? icon
          : Icon(
              icon,
              color: color == null ? Colors.white : color,
            ),
    ).ripple(onTap: onTap == null ? null : onTap);
  }
}

const BorderRadius borderR = BorderRadius.all(
  Radius.circular(5),
);

extension OnPressed on Widget {
  Widget ripple({bR = borderR, onTap}) {
    return Stack(
      children: <Widget>[
        this,
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: bR),
            ),
            onPressed: () {
              if (onTap != null) {
                onTap();
              }
            },
            child: Container(),
          ),
        )
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key key,
    double size = 24,
    Color color,
    @required String iconPath,
    double padding = 15.0,
  })  : _iconPath = iconPath,
        _size = size,
        _color = color,
        _padding = padding,
        super(key: key);

  final String _iconPath;
  final double _size;
  final Color _color;
  final double _padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_padding ?? 4.0),
      child: SvgPicture.asset(
        _iconPath,
        width: _size,
        height: _size,
        color: _color ?? AppTheme.getColor(context),
      ),
    );
  }
}

class CommonHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  CommonHeader({this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline4),
          Expanded(child: Container()),
          CommonIconButton(
            btnColor: Theme.of(context).colorScheme.primaryVariant,
            onTap: () {},
            icon: IconWidget(
              iconPath: 'R.I.icRightArrow',
            ),
          ),
        ],
      ),
    );
  }
}

class FakeInput extends StatelessWidget {
  FakeInput({String hint, String text, Function onTap, prefix})
      : _hint = hint,
        _onTap = onTap,
        _text = text,
        _prefix = prefix;

  final String _hint;
  final String _text;
  final Function _onTap;
  final _prefix;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: AppTheme.kTextMediumColor,
          ),
        ),
        padding: EdgeInsets.only(
          left: 15,
          right: 8,
          top: 5,
          bottom: 5,
        ),
        child: Row(
          children: [
            _prefix == null
                ? SizedBox.shrink()
                : Row(
                    children: [
                      _prefix,
                      SizedBox(width: 15.0),
                      Container(
                        height: 40.0,
                        width: 1.0,
                        color: AppTheme.kTextMediumColor,
                      ),
                      SizedBox(width: 5.0),
                    ],
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _hint,
                    style: AppTheme.hintStyle(),
                  ),
                  _text == ''
                      ? SizedBox.shrink()
                      : Text(
                          _text,
                          style: AppTheme.inputTextStyle().copyWith(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 12.0,
                          ),
                        ),
                ],
              ),
            ),
            CommonIconButton(
              icon: IconWidget(
                iconPath: 'R.I.icForwardArrow',
                padding: 4.0,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> _actions;
  final Widget _leftAction;
  final String _title;
  final String _subtitle;

  CommonAppBar({
    List<Widget> actions,
    Widget leftAction,
    @required String title,
    String subtitle,
    Key key,
  })  : _actions = actions != null ? actions : [],
        _leftAction = leftAction,
        _title = title,
        _subtitle = subtitle,
        super(key: key);

  static const appBarSize = 64.0;
  static const colorTextEnabled = Color.fromRGBO(0, 0, 0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: appBarSize,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: <Widget>[
            SizedBox(width: 15.0),
            Visibility(
              visible: _leftAction == null,
              child: CommonIconButton(
                icon: SvgPicture.asset(
                  R.I.icBack,
                  color: AppTheme.getColor(context),
                  height: 24.0,
                  width: 24.0,
                ),
                onTap: () => Navigator.of(context).pop(),
                btnColor: Theme.of(context).colorScheme.background,
              ),
              replacement: _leftAction ?? SizedBox.shrink(),
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
                  style: _subtitle == null
                      ? TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        )
                      : TextStyle(
                          fontSize: 16,
                          color: colorTextEnabled,
                        ),
                ),
                Visibility(
                  visible: _subtitle != null,
                  child: Text(
                    _subtitle ?? "",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorTextEnabled,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _actions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    String icon,
    String title,
    Function onPressed,
    bool isLoading = false,
    Color color,
    bool iconPlace,
  })  : _icon = icon,
        _title = title,
        _onPressed = onPressed,
        _isLoading = isLoading,
        _color = color;

  final String _icon;
  final String _title;
  final _onPressed;
  final bool _isLoading;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !_isLoading ? _onPressed : null,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        backgroundColor: _color ?? Theme.of(context).colorScheme.primary,
      ),
      child: _isLoading
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox.fromSize(
                    size: Size(48.0, 24.0),
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                IconWidget(
                  iconPath: _icon ?? R.I.icRightArrow,
                  color: Colors.white,
                  padding: 10,
                ),
                Text(
                  _title.toUpperCase(),
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
    );
  }
}

class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton({
    String icon,
    String title,
    Function onPressed,
    bool isLoading = false,
    bool useIcon = false,
  })  : _icon = icon,
        _title = title,
        _onPressed = onPressed,
        _isLoading = isLoading,
        _useIcon = useIcon;

  final String _icon;
  final String _title;
  final _onPressed;
  final bool _isLoading;
  final bool _useIcon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: !_isLoading ? _onPressed : null,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        side: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: _isLoading
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox.fromSize(
                      size: Size(48.0, 24.0),
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).colorScheme.primary,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _useIcon == true
                        ? Row(
                            children: [
                              IconWidget(
                                iconPath: _icon ?? R.I.icRightArrow,
                                padding: 10,
                              ),
                              SizedBox(width: 5.0)
                            ],
                          )
                        : SizedBox.shrink(),
                    Text(
                      _title.toUpperCase(),
                      style: GoogleFonts.quicksand(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class FullDialogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget _action;
  final Widget _leftAction;
  final String _title;
  final String _subtitle;

  const FullDialogAppBar({
    Widget action,
    Widget leftAction,
    @required String title,
    String subtitle,
    Key key,
  })  : _action = action,
        _leftAction = leftAction,
        _title = title,
        _subtitle = subtitle,
        super(key: key);

  static const appBarSize = 64.0;
  static const colorTextEnabled = Color.fromRGBO(0, 0, 0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: appBarSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: <Widget>[
            Visibility(
              visible: _leftAction == null,
              child: CupertinoButton(
                child: IconWidget(
                  iconPath: R.I.icClose,
                  size: 24.0,
                  padding: 8.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              replacement: _leftAction ?? SizedBox.shrink(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: _subtitle == null
                        ? TextStyle(
                            fontSize: 20,
                          )
                        : TextStyle(
                            fontSize: 16,
                          ),
                  ),
                  Visibility(
                    visible: _subtitle != null,
                    child: Text(
                      _subtitle ?? "",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextEnabled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0, // Minimum size of a flat button
              child: _action,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
