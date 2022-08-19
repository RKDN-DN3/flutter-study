import 'dart:math';
import 'package:flutter/animation.dart';

class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}
