import 'package:flutter/material.dart';

extension SizeBoxHelpers on double {
  SizedBox get hSpace => SizedBox(height: this);
  SizedBox get wSpace => SizedBox(width: this);

  String toFahrenheit() => (this * 1.8 + 32).toDouble().toStringAsFixed(1);
}
