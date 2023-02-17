import 'dart:math';
import 'package:flutter/material.dart';

class FlipWidget extends StatelessWidget {
  final bool flip;
  final Widget frontWidget;
  final Widget backWidget;

  const FlipWidget(
      {required this.flip,
      required this.frontWidget,
      required this.backWidget,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(
          children: [widget!, ...list],
        ),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: flip
            ? SizedBox(
                key: const ValueKey('front'),
                child: frontWidget,
              )
            : SizedBox(
                key: const ValueKey('back'),
                child: backWidget,
              ),
      ),
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: child,
      builder: (context, widget) {
        final isFront = ValueKey(flip) == widget!.key;
        final rotateY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotateY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
