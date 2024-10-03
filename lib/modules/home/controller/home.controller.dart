import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/components/loadingPage/loadingPage.component.dart';
import 'package:web_app_demo/helper/lottie.helper.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'dart:js' as js;
import 'package:web_app_demo/models/user.model.dart';
import 'package:web_app_demo/utils/assets.util.dart';
import '../../../models/setUser.model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final Rxn<AnimationController> _animationController =
      Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;
  late AnimationController turnAnimationController;
  RxDouble selectedSector = 0.0.obs;
  Rx<SetUserData> setUserData = SetUserData().obs;
  RxInt totalSpinCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    const duration = Duration(milliseconds: 0);
    _animationController.value = AnimationController(
      vsync: this,
      duration: duration,
    );
    _animationController.value?.forward();

    turnAnimationController = AnimationController(
      vsync: this,
      duration: 60.seconds,
    )..repeat();

    // setUser(UserModel());

    try {
      // Production
      // var state = js.JsObject.fromBrowserObject(js.context['state']);
      // Map<String, dynamic> userData = jsonDecode(state['userData']);
      // UserModel userModel = UserModel.fromJson(userData);
      // if(userModel.id != null && userModel.firstName != null && userModel.lastName != null) {
      //   setUser(userModel);
      // }

      // Development
      Future.delayed(
          200.milliseconds,
          () => setUser(UserModel(
              id: 090900909099, firstName: "deepakTest", lastName: "frrfff")));
    } catch (e) {
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
      "id": userModel.id.toString(),
      "firstName": userModel.firstName,
      "lastName": userModel.lastName
    };

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.setUser, data);
    LoadingPage.close();
    print(resp);

    SetUserModel setUserModel = SetUserModel.fromJson(resp);

    if (setUserModel.responseCode == 200) {
      setUserData.value = setUserModel.data!;
      totalSpinCount.value = ((setUserData.value.spinCount ?? 0) +
          (setUserData.value.referralSpins ?? 0)) as int;
    } else {}
  }

  onSpin() async {
    // LoadingPage.show();
    // var resp = await ApiCall.get(UrlApi.getSpin);
    // LoadingPage.close();
    //
    // ResponseModel responseModel = ResponseModel.fromJson(resp);
    ResponseModel responseModel = ResponseModel(data: 69.6, responseCode: 200);

    if (responseModel.responseCode == 200) {
      const duration = Duration(milliseconds: 1500);
      _animationController.value = AnimationController(vsync: this, duration: duration);
      _animationController.value?.forward();

      if ((responseModel.data ?? 0) >= 70) {
        selectedSector.value = 271.7;
      } else if ((responseModel.data ?? 0) >= 10) {
        selectedSector.value = 91;
      } else if ((responseModel.data ?? 0) >= 5) {
        selectedSector.value = 136.7;
      } else if ((responseModel.data ?? 0) < 5) {
        selectedSector.value = 182.25;
      }

      Future.delayed(2.seconds, () => showSpinAmountDialog(amount: responseModel.data ?? 0));
    } else {
      print("dkljs ${responseModel.message}");
    }
  }

  showSpinAmountDialog({required num amount}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black.withOpacity(0.1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Stack(
              alignment: Alignment.center,
              children: [
                LottieHelper.lottie(
                  animationAsset: AssetsUtil.getConfettiLottie(),
                  repeat: false,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Congratulations! You Get ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: " ₹ 50",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LottieHelper.lottie(
                      animationAsset: AssetsUtil.getRupeeLottie(),
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "₹ $amount",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.primaryFixed,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () => Get.back(),
                      minWidth: 0,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: 150,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              context.theme.colorScheme.primaryFixed,
                              context.theme.colorScheme.secondaryFixed,
                            ],
                          ),
                          border: Border.all(
                              color: context.theme.colorScheme.onSurface
                                  .withOpacity(0.25),
                              width: 1.5),
                        ),
                        child: Text(
                          "GO ON!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurface,
                            height: 1,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
