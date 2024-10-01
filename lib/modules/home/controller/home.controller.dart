import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:js' as js;


class HomeController extends GetxController with GetTickerProviderStateMixin  {
  final Rxn<AnimationController> _animationController = Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;
  RxInt selectedSector = 0.obs;
  RxString user = "".obs;

  @override
  void onInit() {
    super.onInit();
    const duration = Duration(milliseconds: 0);
    _animationController.value = AnimationController(
      vsync: this, duration: duration,
    );
    _animationController.value?.forward();

    try {
      // var state = js.JsObject.fromBrowserObject(js.context['state']);
      var state = js.JsObject.fromBrowserObject(js.context['state']);
      print(state);
      // print(state['hello']);
      print("User Data: ${state['userData']}");
      user.value = state['userData'].toString();
      Map<String, dynamic> userData = jsonDecode(user.value);
      print(userData);
    }
    catch(e) {
      print(e);
    }

  }

  @override
  void onClose() {
    _animationController.value?.dispose();
    super.onClose();
  }

  onClick() {
    const duration = Duration(milliseconds: 1500);
    _animationController.value = AnimationController(
      vsync: this, duration: duration, value: 0.2,
    );
    _animationController.value?.forward();

    selectedSector.value = math.Random().nextInt(12)+1;

    print("dkljs $selectedSector ${(selectedSector)*30}");

  }

}
