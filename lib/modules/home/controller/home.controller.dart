import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin  {
  final Rxn<AnimationController> _animationController = Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;


  @override
  void onInit() {
    super.onInit();
    const duration = Duration(milliseconds: 1500);
    _animationController.value = AnimationController(
      vsync: this, duration: duration,
    );
    _animationController.value?.forward();
  }

  @override
  void onClose() {
    _animationController.value?.dispose();
    super.onClose();
  }

  onClick() {
    const duration = Duration(milliseconds: 1500);
    _animationController.value = AnimationController(
      vsync: this, duration: duration,
    );
    _animationController.value?.forward();
  }

}
