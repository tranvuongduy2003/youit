import 'package:flutter/material.dart';

const designWidth = 428;

double Scale(double number, BuildContext context) {
  double scaleNumber;
  double currentDesignWidth = MediaQuery.of(context).size.width;
  scaleNumber = (number / currentDesignWidth) * designWidth;

  return scaleNumber;
}
