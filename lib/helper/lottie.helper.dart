import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieHelper {
  static Widget lottie({
    required String animationAsset,
    double width = 300,
    double height = 300,
    BoxFit fit = BoxFit.fill,
    bool repeat = true,
  }) {
    return Lottie.asset(
      animationAsset,
      width: width,
      height: height,
      fit: fit,
      repeat: repeat
    );
  }
}