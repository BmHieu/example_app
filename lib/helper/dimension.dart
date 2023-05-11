import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static const designWidth = 390.0;
  static const designHeight = 844.0;

  static void init(BuildContext context) {
    var size = MediaQuery.of(context).size;

    screenWidth = size.width;
    screenHeight = size.height;
  }
}

double getRealHeight(double inputHeight) {
  var screenHeight = SizeConfig.screenHeight;
  return (inputHeight / SizeConfig.designHeight) * screenHeight.toDouble();
}

double getRealWidth(double inputWidth) {
  var screenWidth = SizeConfig.screenWidth;
  return (inputWidth / SizeConfig.designWidth) * screenWidth;
}

extension MultiScreenSizeInt on int {
  double w() {
    var realW = getRealWidth(toDouble());
    return realW;
  }

  double h() {
    var realHeight = getRealHeight(toDouble());
    return realHeight;
  }
}
