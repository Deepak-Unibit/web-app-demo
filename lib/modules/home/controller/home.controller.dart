import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/components/loadingPage/loadingPage.component.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'dart:js' as js;

import 'package:web_app_demo/models/user.model.dart';


class HomeController extends GetxController with GetTickerProviderStateMixin  {
  final Rxn<AnimationController> _animationController = Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;
  late AnimationController turnAnimationController;
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

    turnAnimationController = AnimationController(vsync: this, duration: 10.seconds,)..repeat();

    // setUser(UserModel());

    try {
      var state = js.JsObject.fromBrowserObject(js.context['state']);
      Map<String, dynamic> userData = jsonDecode(state['userData']);
      UserModel userModel = UserModel.fromJson(userData);

      print("user decode data: $userData");
      print("Id: ${userModel.id} firstName: ${userModel.firstName} lastName: ${userModel.lastName} languageCode: ${userModel.languageCode} allow: ${userModel.allowsWriteToPm}");
      user.value = userModel.firstName??"";
      // setUser(userModel);
      // if(userModel.id != null && userModel.firstName != null && userModel.lastName != null) {
      //   setUser(userModel);
      // }

    }
    catch(e) {
      print(e);
    }

  }

  @override
  void onClose() {
    _animationController.value?.dispose();
    turnAnimationController.dispose();
    super.onClose();
  }

  setUser(UserModel userModel) async {
    Map<String, dynamic> data = {
      "id" : userModel.id.toString(),
      "firstName" : userModel.firstName,
      "lastName" : userModel.lastName
    };

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.setUser, data);
    LoadingPage.close();
    print(resp);

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if(responseModel.responseCode == 200) {
      user.value = responseModel.message??"";
    }
    else {
      user.value = responseModel.message ?? "";
    }
  }

  onClick() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getSpin);
    print("Spin ${resp}");
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if(responseModel.responseCode == 200) {
      const duration = Duration(milliseconds: 1500);
      _animationController.value = AnimationController(
        vsync: this, duration: duration
      );
      _animationController.value?.forward();

      selectedSector.value = ((responseModel.data??0) / 12).toInt();

      print("dkljs $selectedSector ${(selectedSector)*30}");
    }
    else {
      print("dkljs ${responseModel.message}");
    }

  }

}
