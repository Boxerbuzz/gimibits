import 'package:flutter/material.dart';

class CenterIcon extends StatelessWidget {
  const CenterIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 35,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: getInverseColor(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }


  static Color getInverseColor(context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Colors.white;
    }
    return Colors.black;
  }
}