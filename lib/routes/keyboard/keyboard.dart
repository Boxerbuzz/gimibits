import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class OnScreenKeyboard extends StatefulWidget {
  @override
  _OnScreenKeyboardState createState() => _OnScreenKeyboardState();
}

class _OnScreenKeyboardState extends State<OnScreenKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: AppTheme.viewportHeight(context) * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.blue.shade700,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              ),
            ),
          ),
          Container(
            height: AppTheme.viewportHeight(context) * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.only(top: 1.0),
            child: GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.4,
              children: List<Widget>.generate(
                12,
                (int index) => _BuildKey(v1: _Keys.getKeys()[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Keys {
  String title;
  bool format;
  String route;

  _Keys({this.format, this.title, this.route});

  static List<_Keys> getKeys() {
    List<_Keys> list = [];
    list.add(_Keys(title: '1'));
    list.add(_Keys(title: '2'));
    list.add(_Keys(title: '3'));
    list.add(_Keys(title: '4'));
    list.add(_Keys(title: '5'));
    list.add(_Keys(title: '6'));
    list.add(_Keys(title: '7'));
    list.add(_Keys(title: '8'));
    list.add(_Keys(title: '9'));
    list.add(_Keys(title: '.'));
    list.add(_Keys(title: '0'));
    list.add(_Keys(title: 'assets/icons/backspace.svg'));
    return list;
  }
}

class _BuildKey extends StatelessWidget {
  final _Keys v1;
  _BuildKey({this.v1});
  @override
  Widget build(BuildContext context) {
    var style = GoogleFonts.barlow(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    //var width = AppTheme.viewportWidth(context) / 3 - 10;
    return Padding(
      padding: EdgeInsets.all(1 / 2),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: v1.title.length > 1
                        ? IconWidget(iconPath: v1.title, padding: 4.0)
                        : Text(
                      v1.title,
                      style: style,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).ripple(onTap: () {});
  }
}

class LoseFocus extends FocusNode {
  @override
  bool get hasFocus => false;
}
