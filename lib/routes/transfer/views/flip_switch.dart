import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlipSwitch extends StatefulWidget {
  FlipSwitch({
    Key key,
    this.color,
    this.bgColor,
    this.rightLabel,
    this.leftLabel,
    this.onChanged,
  }) : super(key: key);
  final Color color;
  final Color bgColor;
  final String rightLabel;
  final String leftLabel;
  final void Function(bool isLeft) onChanged;

  @override
  _FlipSwitchState createState() => _FlipSwitchState();
}

class _FlipSwitchState extends State<FlipSwitch> with TickerProviderStateMixin {
  final double _maxTiltAngle = pi / 6;
  AnimationController _flipCtrl;
  Animation _tiltAnimation;
  AnimationController _tiltCtrl;
  double _directionMultiplier = 1;

  @override
  void initState() {
    super.initState();
    _tiltCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 1500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _tiltCtrl.reverse();
        }
      });

    _tiltAnimation = CurvedAnimation(
      parent: _tiltCtrl,
      curve: Curves.easeOut,
      reverseCurve: Curves.elasticOut.flipped,
    );

    _flipCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _jumpTo(true);
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    _tiltCtrl.dispose();
    super.dispose();
  }

  void _jumpTo(bool leftEnabled) {
    _flipCtrl.value = leftEnabled ? 1.0 : 0.0;
  }

  void _toggle() {
    if (_flipCtrl.isCompleted) {
      _directionMultiplier = -1;
      _tiltCtrl.forward();
      _flipCtrl.reverse();

      widget.onChanged?.call(false);
    } else {
      _directionMultiplier = 1;
      _tiltCtrl.forward();
      _flipCtrl.forward();
      widget.onChanged?.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _tiltAnimation,
        child: Stack(
          children: [
            _buildTabBackground(),
            AnimatedBuilder(
              animation: _flipCtrl,
              builder: (context, child) {
                return _buildFlipSwitch(pi * _flipCtrl.value);
              },
            ),
          ],
        ),
        builder: (context, tabs) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  _tiltAnimation.value * _maxTiltAngle * _directionMultiplier),
            alignment: FractionalOffset(0.5, 1.0),
            child: tabs,
          );
        });
  }

  Widget _buildTabBackground() {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: widget.color),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  widget.leftLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.rightLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipSwitch(double angle) {
    final bool isLeft = angle > (pi / 2);
    final transformAngle = isLeft ? angle - pi : angle;
    return Positioned(
      top: 0,
      bottom: 0,
      right: isLeft ? null : 0,
      left: isLeft ? 0 : null,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(transformAngle),
        alignment:
            isLeft ? FractionalOffset(1.0, 1.0) : FractionalOffset(0.0, 1.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 50,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.only(
              topRight: isLeft ? Radius.zero : Radius.circular(8),
              bottomRight: isLeft ? Radius.zero : Radius.circular(8),
              topLeft: isLeft ? Radius.circular(8) : Radius.zero,
              bottomLeft: isLeft ? Radius.circular(8) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              isLeft ? widget.leftLabel : widget.rightLabel,
              style: TextStyle(
                color: widget.bgColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
