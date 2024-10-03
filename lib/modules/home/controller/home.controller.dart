import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/components/loadingPage/loadingPage.component.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'package:web_app_demo/models/spin.model.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:web_app_demo/models/user.model.dart';
import 'package:web_app_demo/models/verifySubscription.model.dart';
import 'package:web_app_demo/modules/home/components/getSpinDialogComponent.dart';
import 'package:web_app_demo/modules/home/components/inviteDialog.component.dart';
import 'package:web_app_demo/modules/home/components/spinWinAmountDialog.component.dart';
import '../../../models/setUser.model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final Rxn<AnimationController> _animationController =
      Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;
  late AnimationController turnAnimationController;
  RxDouble selectedSector = 0.0.obs;
  UserModel userModel = UserModel();
  VerifySubscriptionData verifySubscriptionData = VerifySubscriptionData();
  Rx<SetUserData> setUserData = SetUserData().obs;
  RxInt totalSpinCount = 0.obs;
  bool isSpinning = false;

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

    try {
      // Production
      var state = js.JsObject.fromBrowserObject(js.context['state']);
      Map<String, dynamic> userData = jsonDecode(state['userData']);
      print(userData);
      userModel = UserModel.fromJson(userData);
      if(userModel.id != null && userModel.firstName != null && userModel.lastName != null) {
        Future.delayed(200.milliseconds, () => verifySubscription(userModel.id??0));
      }

      // Development
      // userModel = UserModel(id: 1146609300, firstName: "deepakTest", lastName: "frrfff");

      Future.delayed(200.milliseconds, () => verifySubscription(userModel.id??0));
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

  verifySubscription(num telegramId) async {
    LoadingPage.show();
    var resp = await ApiCall.get("${UrlApi.verifySubscription}/$telegramId");
    LoadingPage.close();

    // Production
    VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel.fromJson(resp);

    // Development
    // VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel(
    //   responseCode: 200,
    //   data: VerifySubscriptionData(
    //     joinedChannel1: false,
    //     joinedChannel2: true,
    //   ),
    // );

    if (verifySubscriptionModel.responseCode == 200) {
      verifySubscriptionData = verifySubscriptionModel.data!;

      if ((verifySubscriptionData.joinedChannel1 ?? false) && (verifySubscriptionData.joinedChannel2 ?? false)) {
        setUser(userModel);
      }
      else {
        GetSpinDialogComponent.show(
          text: "Join Channel & Get Spin",
          onJoinChannelClick: onJoinChannelClick,
          onContinueClick: onContinueClick,
          channel1Status: verifySubscriptionData.joinedChannel1??false ? 1 : 0,
          channel2Status: verifySubscriptionData.joinedChannel2??false ? 1 : 0,
        );
      }
    } else {
      print(verifySubscriptionModel.data);
    }
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
    if (isSpinning) {
      return;
    }

    if (totalSpinCount.value <= 0) {
      getMoreSpin();
      return;
    }

    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getSpin);
    LoadingPage.close();
    print(resp);

    SpinModel spinModel = SpinModel.fromJson(resp);
    // SpinModel spinModel = SpinModel(data: SpinData(earnedAmount: 0, spinAmount: 46, referralSpins: 0, spinCount: 0), responseCode: 200);

    if (spinModel.responseCode == 200) {
      const duration = Duration(milliseconds: 1500);
      _animationController.value =
          AnimationController(vsync: this, duration: duration);
      _animationController.value?.forward();

      isSpinning = true;

      if ((spinModel.data?.spinAmount ?? 0) >= 70) {
        selectedSector.value = 271.7;
      } else if ((spinModel.data?.spinAmount ?? 0) >= 10) {
        selectedSector.value = 91;
      } else if ((spinModel.data?.spinAmount ?? 0) >= 5) {
        selectedSector.value = 136.7;
      } else if ((spinModel.data?.spinAmount ?? 0) < 5) {
        selectedSector.value = 182.25;
      }

      Future.delayed(2.seconds, () {
        isSpinning = false;
        setUserData.value.setEarnedAmount = spinModel.data?.earnedAmount ?? 0;
        setUserData.value.setSpinCount = spinModel.data?.spinCount ?? 0;
        setUserData.value.setReferralSpins = spinModel.data?.referralSpins ?? 0;
        setUserData.refresh();
        totalSpinCount.value = ((setUserData.value.spinCount ?? 0) +
            (setUserData.value.referralSpins ?? 0)) as int;

        SpinWinAmountDialogComponent.show(
            amount: spinModel.data?.spinAmount ?? 0);
      });
    } else {
      print("dkljs ${spinModel.message}");
    }
  }

  getMoreSpin() {
    InviteDialogComponent.show(
        onClick: onContinueToGetMoreSpin, setUserData: setUserData.value);
  }

  onContinueToGetMoreSpin() {
    Get.back();
    String telegramLink =
        'https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode}';

    html.window.open(telegramLink, '_blank');
  }

  onInviteForSpins() {
    String telegramLink =
        'https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode}';

    html.window.open(telegramLink, '_blank');
  }

  onJoinChannelClick(int type) {
    String telegramLink = 'https://t.me/test2channelforsaquib';
    // 'https://t.me/share/url?url=https://t.me/catizenbot/gameapp?startapp=rp_1365932&text=%F0%9F%92%B0Catizen%3A%20Unleash%2C%20Play%2C%20Earn%20-%20Where%20Every%20Game%20Leads%20to%20an%20Airdrop%20Adventure!%0A%F0%9F%8E%81Let%27s%20play-to-earn%20airdrop%20right%20now!'

    html.window.open(telegramLink, '_blank');
    Get.back();
    GetSpinDialogComponent.show(
      text: "Continue",
      channel1Status: type == 0 ? 1 : (verifySubscriptionData.joinedChannel1??false)?1:0,
      channel2Status: type == 1 ? 1 : (verifySubscriptionData.joinedChannel2??false)?1:0,
      onJoinChannelClick: onJoinChannelClick,
      onContinueClick: onContinueClick,
    );
  }

  onContinueClick() {
    Get.back();
    verifySubscription(userModel.id ?? 0);
  }
}
