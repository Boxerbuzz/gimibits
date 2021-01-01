import 'package:flutter/material.dart';

class ExpandingDotsPainter extends IndicatorPainter {
  final ExpandingDotsEffect effect;

  ExpandingDotsPainter({
    @required double offset,
    @required this.effect,
    @required int count,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    final current = offset.floor();
    var drawingOffset = -effect.spacing;
    final dotOffset = offset - current;

    for (var i = 0; i < count; i++) {
      var color = effect.dotColor;
      final activeDotWidth = effect.dotWidth * effect.expansionFactor;
      final expansion =
          (dotOffset / 2 * ((activeDotWidth - effect.dotWidth) / .5));
      final xPos = drawingOffset + effect.spacing;
      var width = effect.dotWidth;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
        width = activeDotWidth - expansion;
      } else if (i - 1 == current) {
        width = effect.dotWidth + expansion;
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset);
      }
      final yPos = size.height / 2;
      final rRect = RRect.fromLTRBR(
        xPos,
        yPos - effect.dotHeight / 2,
        xPos + width,
        yPos + effect.dotHeight / 2,
        dotRadius,
      );
      drawingOffset = rRect.right;
      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}

class WormPainter extends IndicatorPainter {
  final WormEffect effect;

  WormPainter({
    @required this.effect,
    @required int count,
    @required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
//    super.paint(canvas, size);
    // paint still dots
    paintStillDots(canvas, size);
    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    final worm = _calcBounds(size.height, offset.floor(), dotOffset * 2);
    canvas.drawRRect(worm, activeDotPaint);
  }

  RRect _calcBounds(double canvasHeight, num i, double dotOffset) {
    final xPos = (i * distance);
    final yPos = canvasHeight / 2;
    double left = xPos;
    double right = xPos +
        effect.dotWidth +
        (dotOffset * (effect.dotWidth + effect.spacing));
    if (dotOffset > 1) {
      right = xPos + effect.dotWidth + (1 * (effect.dotWidth + effect.spacing));
      left = xPos + ((effect.spacing + effect.dotWidth) * (dotOffset - 1));
    }
    return RRect.fromLTRBR(
      left,
      yPos - effect.dotHeight / 2,
      right,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );
  }
}

abstract class IndicatorEffect {
  /// Singe dot width
  final double dotWidth;

  /// Singe dot height
  final double dotHeight;

  /// The horizontal space between dots
  final double spacing;

  /// Single dot radius
  final double radius;

  /// Inactive dots color or all dots in some effects
  final Color dotColor;

  /// The active dot color
  final Color activeDotColor;

  /// Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle paintStyle;

  /// This is ignored if [paintStyle] is PaintStyle.fill
  final double strokeWidth;

  const IndicatorEffect({
    @required this.strokeWidth,
    @required this.dotWidth,
    @required this.dotHeight,
    @required this.spacing,
    @required this.radius,
    @required this.dotColor,
    @required this.paintStyle,
    @required this.activeDotColor,
  })  : assert(radius != null),
        assert(dotColor != null || paintStyle != null || strokeWidth != null),
        assert(activeDotColor != null),
        assert(dotWidth != null),
        assert(dotHeight != null),
        assert(spacing != null),
        assert(dotWidth >= 0 &&
            dotHeight >= 0 &&
            spacing >= 0 &&
            strokeWidth >= 0);

  /// Builds a new painter every time the page offset changes
  IndicatorPainter buildPainter(int count, double offset);

  /// Calculates the size of canvas based on
  /// dots count, size and spacing
  ///
  /// Other effects can override this function
  /// to calculate their own size
  Size calculateSize(int count) {
    return Size(dotWidth * count + (spacing * (count - 1)), dotHeight);
  }

  /// Returns the index of the section that contains [dx].
  ///
  /// Sections or hit-targets are calculated differently
  /// in some effects
  int hitTestDots(double dx, int count, double current) {
    var offset = -spacing / 2;
    for (var index = 0; index < count; index++) {
      if (dx <= (offset += dotWidth + spacing)) {
        return index;
      }
    }
    return -1;
  }
}

abstract class IndicatorPainter extends CustomPainter {
  /// The raw offset from the [PageController].page
  /// This holds the directional offset
  final double offset;

  /// The count of pages
  final int count;

  // The provided effect is passed to this super class
  // to make some calculations and paint still dots
  final IndicatorEffect _effect;

  /// Inactive dot paint or base paint in one-color effects.
  final Paint dotPaint;

  /// The Radius of all dots
  final Radius dotRadius;

  IndicatorPainter(
    this.offset,
    this.count,
    this._effect,
  )   : assert(offset.ceil() < count, 'Current page is out of bounds'),
        dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth;

  // The distance between dot lefts
  double get distance => _effect.dotWidth + _effect.spacing;

  void paintStillDots(Canvas canvas, Size size) {
    for (var i = 0; i < count; i++) {
      final xPos = (i * distance);
      final yPos = size.height / 2;
      final bounds = Rect.fromLTRB(xPos, yPos - _effect.dotHeight / 2,
          xPos + _effect.dotWidth, yPos + _effect.dotHeight / 2);
      var rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    // only repaint if the raw offset changes
    return oldDelegate.offset != offset;
  }
}

class ExpandingDotsEffect extends IndicatorEffect {
  /// [expansionFactor] is multiplied by [dotWidth] to resolve
  /// the width of the expanded dot.
  final double expansionFactor;

  const ExpandingDotsEffect({
    this.expansionFactor = 3,
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16.0,
    Color activeDotColor = Colors.indigo,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(expansionFactor != null),
        assert(expansionFactor > 1),
        super(
            dotWidth: dotWidth,
            dotHeight: dotHeight,
            spacing: spacing,
            radius: radius,
            strokeWidth: strokeWidth,
            paintStyle: paintStyle,
            dotColor: dotColor,
            activeDotColor: activeDotColor);

  @override
  Size calculateSize(int count) {
    // Add the expanded dot width to our size calculation
    return Size(
        ((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth),
        dotHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ExpandingDotsPainter(count: count, offset: offset, effect: this);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    var anchor = -spacing / 2;
    for (var index = 0; index < count; index++) {
      var widthBound =
          (index == current ? (dotWidth * expansionFactor) : dotWidth) +
              spacing;
      if (dx <= (anchor += widthBound)) {
        return index;
      }
    }
    return -1;
  }
}

class WormEffect extends IndicatorEffect {
  const WormEffect({
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  }) : super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return WormPainter(count: count, offset: offset, effect: this);
  }
}

typedef OnDotClicked = void Function(int index);

class SmoothPageIndicator extends AnimatedWidget {
  // Page view controller
  final PageController controller;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  ///
  /// This will only rotate the canvas in which the dots
  /// are drawn,
  /// It will not affect [effect.dotWidth] and [effect.dotHeight]
  final Axis axisDirection;

  /// The number of pages
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection textDirection;

  /// on dot clicked callback
  final OnDotClicked onDotClicked;

  SmoothPageIndicator({
    Key key,
    @required this.controller,
    @required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      offset: _offset,
      count: count,
      effect: effect,
      textDirection: textDirection,
      axisDirection: axisDirection,
      onDotClicked: onDotClicked,
    );
  }

  double get _offset {
    try {
      return controller.page ?? controller.initialPage.toDouble();
    } catch (_) {
      return controller.initialPage.toDouble();
    }
  }
}

class SmoothIndicator extends StatelessWidget {
  // to listen for page offset updates
  final double offset;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of pages
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection textDirection;

  /// on dot clicked callback
  final OnDotClicked onDotClicked;

  /// canvas size
  final Size _size;

  SmoothIndicator({
    @required this.offset,
    @required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
    Key key,
  })  : assert(offset != null),
        assert(effect != null),
        assert(count != null),
        // different effects have different sizes
        // so we calculate size based on the provided effect
        _size = effect.calculateSize(count),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL =
        (textDirection ?? Directionality.of(context)) == TextDirection.rtl;

    return RotatedBox(
      quarterTurns: axisDirection == Axis.vertical
          ? 1
          : isRTL
              ? 2
              : 0,
      child: GestureDetector(
        onTapUp: _onTap,
        child: CustomPaint(
          size: _size,
          // rebuild the painter with the new offset every time it updates
          painter: effect.buildPainter(count, offset),
        ),
      ),
    );
  }

  void _onTap(details) {
    if (onDotClicked != null) {
      var index = effect.hitTestDots(
        details.localPosition.dx,
        count,
        offset,
      );
      if (index != -1 && index != offset.toInt()) {
        onDotClicked(index);
      }
    }
  }
}

class AnimatedSmoothIndicator extends ImplicitlyAnimatedWidget {
  final int activeIndex;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection textDirection;

  /// On dot clicked callback
  final Function(int index) onDotClicked;

  AnimatedSmoothIndicator({
    @required this.activeIndex,
    @required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback onEnd,
    Key key,
  })  : assert(effect != null),
        assert(activeIndex != null),
        assert(count != null),
        assert(duration != null),
        assert(curve != null),
        super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
        );

  @override
  _AnimatedSmoothIndicatorState createState() =>
      _AnimatedSmoothIndicatorState();
}

class _AnimatedSmoothIndicatorState
    extends AnimatedWidgetBaseState<AnimatedSmoothIndicator> {
  Tween<double> _offset;

  @override
  void forEachTween(visitor) {
    _offset = visitor(
      _offset,
      widget.activeIndex.toDouble(),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      offset: _offset?.evaluate(animation),
      count: widget.count,
      effect: widget.effect,
      textDirection: widget.textDirection,
      axisDirection: widget.axisDirection,
      onDotClicked: widget.onDotClicked,
    );
  }
}
