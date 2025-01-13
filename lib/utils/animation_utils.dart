import 'package:flutter/material.dart';

class AnimationUtils {
  static Duration get defaultDuration => const Duration(milliseconds: 300);
  static Duration get longDuration => const Duration(milliseconds: 500);
  static Duration get veryLongDuration => const Duration(seconds: 1);

  static Curve get defaultCurve => Curves.easeInOut;
  static Curve get bounceCurve => Curves.bounceOut;
  static Curve get elasticCurve => Curves.elasticOut;

  static Animation<T> chain<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    Curve curve = Curves.linear,
    double startPoint = 0.0,
    double endPoint = 1.0,
  }) {
    return Tween<T>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(startPoint, endPoint, curve: curve),
      ),
    );
  }
}
