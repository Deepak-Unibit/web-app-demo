import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'dart:js' as js;

import 'package:web_app_demo/models/user.model.dart';


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
      print("jsonDecode: ${jsonDecode(state['userData'])}");
      // print(state['hello']);
      Map<String, dynamic> userData = jsonDecode(state['userData']);
      UserModel userModel = UserModel.fromJson(userData);

      print("user decode data: $userData");
      print("Id: ${userModel.id} firstName: ${userModel.firstName} lastName: ${userModel.lastName} languageCode: ${userModel.languageCode} allow: ${userModel.allowsWriteToPm}");
      user.value = userModel.firstName??"";
      if(userModel.id != null && userModel.firstName != null && userModel.lastName != null) {
        setUser(userModel);
      }

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

  setUser(UserModel userModel) async {
    Map<String, dynamic> data = {
      "id" : userModel.id,
      "firstName" : userModel.firstName,
      "lastName" : userModel.lastName
    };

    var resp = await ApiCall.post(UrlApi.setUser, data);

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if(responseModel.responseCode == 200) {
      user.value = responseModel.message??"";
    }
    else {
      user.value = responseModel.message ?? "";
    }
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
