import 'package:flutter/material.dart';

class BoxPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final DecorationImage image;
  final BoxShadow shadow;
  final double width;
  final Color color;
  final EdgeInsets padding;
  final double radius;

  BoxPanel({
    Key key,
    this.child,
    this.image,
    this.shadow,
    this.margin,
    this.width = double.infinity,
    this.color,
    this.padding = _padding,
    this.radius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: this.margin,
      padding: this.padding,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
        image: this.image,
      ),
      child: this.child,
    );
  }
}

const EdgeInsets _padding = EdgeInsets.symmetric(
  horizontal: 10.0 * 2,
  vertical: 10.0 * 1.5,
);