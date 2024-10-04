import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/components/loadingPage/loadingPage.component.dart';
import 'package:web_app_demo/helper/regex.helper.dart';
import 'package:web_app_demo/models/invitation.model.dart';
import 'package:web_app_demo/models/myProfile.model.dart';
import 'package:web_app_demo/models/myRank.model.dart';
import 'package:web_app_demo/models/rank.model.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'package:web_app_demo/models/spin.model.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:web_app_demo/models/user.model.dart';
import 'package:web_app_demo/models/verifySubscription.model.dart';
import 'package:web_app_demo/models/withdrawDetails.model.dart';
import 'package:web_app_demo/models/withdrawRequest.model.dart';
import 'package:web_app_demo/modules/home/components/accountInfoDialog.component.dart';
import 'package:web_app_demo/modules/home/components/cashOutDialog.component.dart';
import 'package:web_app_demo/modules/home/components/invitationListDialog.component.dart';
import 'package:web_app_demo/modules/home/components/inviteDialog.component.dart';
import 'package:web_app_demo/modules/home/components/rankDialog.component.dart';
import 'package:web_app_demo/modules/home/components/spinWinAmountDialog.component.dart';
import 'package:web_app_demo/modules/home/components/withdrawHistoryDialog.component.dart';
import '../../../models/setUser.model.dart';
import '../components/getSpinDialog.component.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

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
      // var state = js.JsObject.fromBrowserObject(js.context['state']);
      // Map<String, dynamic> userData = jsonDecode(state['userData']);
      // userModel = UserModel.fromJson(userData);

      // Development
      userModel = UserModel(
        id: 1146609300,
        firstName: "Deepak Kumar",
        lastName: "Behera",
        allowsWriteToPm: true,
      );


      if (userModel.id != null &&
          userModel.firstName != null &&
          userModel.lastName != null) {
        Future.delayed(
            200.milliseconds, () => verifySubscription(userModel.id ?? 0));
      }
    } catch (e) {
    }
  }

  @override
  void onClose() {
    _animationController.value?.dispose();
    turnAnimationController.dispose();
    super.onClose();
  }

  verifySubscription(num telegramId) async {
    // Production
    LoadingPage.show();
    var resp = await ApiCall.getWithOutEncryption("${UrlApi.verifySubscription}/$telegramId");
    LoadingPage.close();

    VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel.fromJson(resp);

    // Development
    // VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel(
    //   responseCode: 200,
    //   data: VerifySubscriptionData(
    //     joinedChannel1: true,
    //     joinedChannel2: true,
    //   ),
    // );

    if (verifySubscriptionModel.responseCode == 200) {
      verifySubscriptionData = verifySubscriptionModel.data!;

      if ((verifySubscriptionData.joinedChannel1 ?? false) && (verifySubscriptionData.joinedChannel2 ?? false)) {
        setUser(userModel);
      } else {
        GetSpinDialogComponent.show(
          text: "Join Channel & Get Spin",
          onJoinChannelClick: onJoinChannelClick,
          onContinueClick: onContinueClick,
          channel1Status: verifySubscriptionData.joinedChannel1 ?? false ? 2 : 0,
          channel2Status: verifySubscriptionData.joinedChannel2 ?? false ? 2 : 0,
        );
      }
    } else {
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

  onRankClick() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getRankList);
    print(resp);
    RankModel rankModel = RankModel.fromJson(resp);

    if (rankModel.responseCode == 200) {
      var resp = await ApiCall.get(UrlApi.getMyRank);
      LoadingPage.close();
      MyRankModel myRankModel = MyRankModel.fromJson(resp);
      if (myRankModel.responseCode == 200) {
        RankDialogComponent.show(
          rankDataList: rankModel.data!,
          myName: setUserData.value.firstName ?? "",
          myRank: myRankModel.data!.myRank!,
          myReferralCount: myRankModel.data!.myReferral!,
        );
      }
    } else {
      LoadingPage.close();
    }
  }

  onInvitation() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getInvitationList);
    LoadingPage.close();
    print(resp);
    InvitationModel invitationModel = InvitationModel.fromJson(resp);

    if(invitationModel.responseCode == 200) {
      InvitationListDialogComponent.show(invitationDataList: invitationModel.data??[]);
    }
    else {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: Text(
          invitationModel.message??"",
          textAlign: TextAlign.center,
        ),
        maxWidth: 250,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
    }
  }

  onCashOut() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getProfile);
    print(resp);
    MyProfileModel myProfileModel = MyProfileModel.fromJson(resp);

    if (myProfileModel.responseCode == 200) {
      var resp = await ApiCall.get(UrlApi.getWithdrawDetails);
      LoadingPage.close();

      WithdrawDetailsModel withdrawDetailsModel = WithdrawDetailsModel.fromJson(resp);

      if (withdrawDetailsModel.responseCode == 200) {
        CashOutDialogComponent.show(
            onEdit: onEditAccount,
            onWithdrawRecord: onWithdrawRecord,
            onWithdraw: onWithdraw,
            myProfileData: myProfileModel.data ?? MyProfileData(),
            withdrawDetailsData: withdrawDetailsModel.data ?? WithdrawDetailsData());
      }
    } else {
      LoadingPage.close();
    }
  }

  onWithdrawRecord() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getWithdrawList);
    LoadingPage.close();
    print(resp);
    WithdrawRequestModel withdrawRequestModel = WithdrawRequestModel.fromJson(resp);

    if(withdrawRequestModel.responseCode == 200) {
      WithdrawHistoryDialogComponent.show(withdrawRequestDataList: withdrawRequestModel.data??[]);
    }
  }

  onWithdraw() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.cashOutRequest);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      setUserData.value.setEarnedAmount = 0;
      setUserData.refresh();
      Get.back();
      onCashOut();
    } else {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: Text(
          responseModel.message ?? "",
          textAlign: TextAlign.center,
        ),
        maxWidth: 250,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
    }
  }

  onEditAccount() {
    Get.back();
    AccountInfoDialogComponent.show(
      nameController: nameController,
      upiController: upiController,
      mobileNumberController: mobileNumberController,
      onBack: onEditBackClick,
      onSave: onSaveAccountInfo,
    );
  }

  onEditBackClick() {
    Get.back();
    onCashOut();
  }

  onSaveAccountInfo() async {
    nameController.text = nameController.text.trim();
    upiController.text = upiController.text.trim();
    mobileNumberController.text = mobileNumberController.text.trim();

    if (!(RegexHelper.nameRegex.hasMatch(nameController.text))) {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: const Text(
          "Enter valid name",
          textAlign: TextAlign.center,
        ),
        maxWidth: 250,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
      return;
    } else if (upiController.text == "") {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: const Text(
          "Enter valid UPI ID",
          textAlign: TextAlign.center,
        ),
        maxWidth: 250,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
      return;
    } else if (!(RegexHelper.mobileRegex
        .hasMatch(mobileNumberController.text))) {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: const Text(
          "Enter valid mobile number",
          textAlign: TextAlign.center,
        ),
        maxWidth: 250,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
      return;
    }

    Map<String, dynamic> data = {
      "upiId": upiController.text,
      "phoneNumber": mobileNumberController.text,
      "accountHolderName": nameController.text
    };

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.addUpiDetails, data);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      Get.back();
      onCashOut();
    } else {
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: Text(
          responseModel.message ?? "",
          textAlign: TextAlign.center,
        ),
        maxWidth: 150,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
    }
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

    SpinModel spinModel = SpinModel.fromJson(resp);

    if (spinModel.responseCode == 200) {
      const duration = Duration(milliseconds: 1500);
      _animationController.value = AnimationController(vsync: this, duration: duration);
      _animationController.value?.forward();

      isSpinning = true;

      if ((spinModel.data?.spinAmount ?? 0) >= 70) {
        selectedSector.value = 180;
      } else if ((spinModel.data?.spinAmount ?? 0) >= 10) {
        selectedSector.value = 90;
      } else if ((spinModel.data?.spinAmount ?? 0) >= 5) {
        selectedSector.value = 135;
      } else if ((spinModel.data?.spinAmount ?? 0) < 5) {
        Random random = Random();
        int randomNumber = random.nextInt(3);
        selectedSector.value = randomNumber==0 ? 225 : randomNumber==1 ? 270 : 315;
      }

      Future.delayed(2.seconds, () {
        isSpinning = false;
        setUserData.value.setEarnedAmount = spinModel.data?.earnedAmount ?? 0;
        setUserData.value.setSpinCount = spinModel.data?.spinCount ?? 0;
        setUserData.value.setReferralSpins = spinModel.data?.referralSpins ?? 0;
        setUserData.refresh();
        totalSpinCount.value = ((setUserData.value.spinCount ?? 0) + (setUserData.value.referralSpins ?? 0)) as int;

        SpinWinAmountDialogComponent.show(amount: spinModel.data?.spinAmount ?? 0);
      });
    } else {
    }
  }

  getMoreSpin() {
    InviteDialogComponent.show(
        onClick: onContinueToGetMoreSpin, setUserData: setUserData.value);
  }

  onContinueToGetMoreSpin() {
    Get.back();
    String telegramLink = "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} %0A🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 %0AClick URL and play with me!%0A💰Let's stike it rich together!💰";

    html.window.open(telegramLink, '_blank');
  }

  onInviteForSpins() {
    String telegramLink = "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} %0A🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 %0AClick URL and play with me!%0A💰Let's stike it rich together!💰";

    html.window.open(telegramLink, '_blank');
  }

  onCopyClick() async {
    html.window.navigator.clipboard?.writeText('https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} \n\n🎁I\'ve won ₹${setUserData.value.earnedAmount} from this Game!🎁 \n\nClick URL and play with me!\n💰Let\'s stike it rich together!💰').then((_) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "",
        "",
        titleText: const SizedBox.shrink(),
        duration: 2.seconds,
        messageText: const Text(
          "Copied to Clipboard",
          textAlign: TextAlign.center,
        ),
        maxWidth: 150,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
      );
    }).catchError((e) {
      print("Failed to copy text to clipboard: $e");
    });
    // await Clipboard.setData(ClipboardData(text: 'https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} \n\n🎁I\'ve won ₹${setUserData.value.earnedAmount} from this Game!🎁 \n\nClick URL and play with me!\n💰Let\'s stike it rich together!💰'));

  }

  onJoinChannelClick(int type) {
    String telegramLink = "";
    if (type == 0) {
      telegramLink = 'https://t.me/ludo24_app';
    } else {
      telegramLink = 'https://t.me/Wheel24';
    }

    html.window.open(telegramLink, '_blank');
    Get.back();
    GetSpinDialogComponent.show(
      text: "Continue",
      channel1Status: type == 0
          ? 1
          : (verifySubscriptionData.joinedChannel1 ?? false)
              ? 2
              : 0,
      channel2Status: type == 1
          ? 1
          : (verifySubscriptionData.joinedChannel2 ?? false)
              ? 2
              : 0,
      onJoinChannelClick: onJoinChannelClick,
      onContinueClick: onContinueClick,
    );
  }

  onContinueClick() {
    Get.back();
    verifySubscription(userModel.id ?? 0);
  }

  onShareClick(int index) {
      String message = "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} \n🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 \nClick URL and play with me!\n💰Let's stike it rich together!💰";

    if(index==0) {
      final String whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
      js.context.callMethod('open', [whatsappUrl, '_blank']);
    }
    else if(index==1) {
      final String twitterUrl = 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent("Wheel24")}&url=${Uri.encodeComponent(message)}';

      // Open Twitter share dialog in a new tab
      js.context.callMethod('open', [twitterUrl, '_blank']);
    }
    else if(index==2) {
      final String facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(message)}';

      // Open Facebook share dialog in a new tab
      js.context.callMethod('open', [facebookUrl, '_blank']);
    }
    else {
      // Check if the Web Share API is supported
      html.window.navigator.share({
        'title': "Wheel24",
        'text': "Wheel24",
        'url': message,
      }).then((_) {
      }).catchError((e) {
        print("Error sharing content: $e");
      });
    }

    }
}
