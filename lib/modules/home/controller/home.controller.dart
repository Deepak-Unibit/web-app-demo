import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';
import 'package:web_app_demo/api/call.api.dart';
import 'package:web_app_demo/api/url.api.dart';
import 'package:web_app_demo/components/loadingPage/loadingPage.component.dart';
import 'package:web_app_demo/helper/regex.helper.dart';
import 'package:web_app_demo/helper/snackBar.helper.dart';
import 'package:web_app_demo/models/cashOut.model.dart';
import 'package:web_app_demo/models/dailyRewards.model.dart';
import 'package:web_app_demo/models/invitation.model.dart';
import 'package:web_app_demo/models/myProfile.model.dart';
import 'package:web_app_demo/models/myRank.model.dart';
import 'package:web_app_demo/models/rank.model.dart';
import 'package:web_app_demo/models/response.model.dart';
import 'package:web_app_demo/models/rewards.model.dart';
import 'package:web_app_demo/models/settings.model.dart';
import 'package:web_app_demo/models/spin.model.dart';
import 'package:web_app_demo/models/taskList.model.dart';
import 'package:web_app_demo/models/taskRedeemHistory.model.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' as http;
import 'package:web_app_demo/models/user.model.dart';
import 'package:web_app_demo/models/verifySubscription.model.dart';
import 'package:web_app_demo/models/withdrawDetails.model.dart';
import 'package:web_app_demo/models/withdrawRequest.model.dart';
import 'package:web_app_demo/modules/home/components/accountInfoDialog.component.dart';
import 'package:web_app_demo/modules/home/components/cashOutDialog.component.dart';
import 'package:web_app_demo/modules/home/components/claimDiamondDialog.component.dart';
import 'package:web_app_demo/modules/home/components/diamondToSpinDialog.component.dart';
import 'package:web_app_demo/modules/home/components/invitationListDialog.component.dart';
import 'package:web_app_demo/modules/home/components/inviteDialog.component.dart';
import 'package:web_app_demo/modules/home/components/rankDialog.component.dart';
import 'package:web_app_demo/modules/home/components/rewardsDialog.component.dart';
import 'package:web_app_demo/modules/home/components/spinWinAmountDialog.component.dart';
import 'package:web_app_demo/modules/home/components/taskRedeemHistoryDialog.component.dart';
import 'package:web_app_demo/modules/home/components/withdrawHistoryDialog.component.dart';
import '../../../models/setUser.model.dart';
import '../components/extraTaskDialog.component.dart';
import '../components/getSpinDialog.component.dart';
import '../components/uploadProofDialog.component.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  UserModel userModel = UserModel();
  VerifySubscriptionData verifySubscriptionData = VerifySubscriptionData();
  Rx<SetUserData> setUserData = SetUserData().obs;
  RxInt goalAmount = 0.obs;
  RxInt totalSpinCount = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  RxBool showExtraCash = false.obs;
  RxList<TaskListData> taskDataList = <TaskListData>[].obs;
  RxInt totalDiamond = 0.obs;
  RxList<int> activeTimerIndexList = <int>[].obs;
  final RxList<int> remainingTimes = <int>[].obs;
  Rx<DailyRewardsData> dailyRewardsData = DailyRewardsData().obs;
  RxString uploadedProofFile = "".obs;

  RxList<String> cardsList = <String>[].obs;
  final GlobalKey<ScratcherState> scratchKey = GlobalKey<ScratcherState>();

  HomeController() {
    try {
      // Production
      var state = js.JsObject.fromBrowserObject(js.context['state']);
      Map<String, dynamic> userData = jsonDecode(state['userData']);
      userModel = UserModel.fromJson(userData);

      print(userData);

      // Development
      // userModel = UserModel(
      //   id: 1146609300,
      //   firstName: "New3 Kumar",
      //   lastName: "Behera",
      //   allowsWriteToPm: true,
      // );

      if (userModel.id != null && userModel.firstName != null && userModel.lastName != null) {
        Future.delayed(200.milliseconds, () => verifySubscription(userModel.id ?? 0));
      }
    } catch (e) {
      print(e);
    }

    for (int i = 0; i < 10; i++) {
      cardsList.add(getCoverImage());
    }
  }

  verifySubscription(num telegramId) async {
    // Production
    // LoadingPage.show();
    // var resp = await ApiCall.getWithOutEncryption("${UrlApi.verifySubscription}/$telegramId");
    // LoadingPage.close();
    //
    // VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel.fromJson(resp);

    // Development
    VerifySubscriptionModel verifySubscriptionModel = VerifySubscriptionModel(
      responseCode: 200,
      data: VerifySubscriptionData(
        joinedChannel1: true,
        joinedChannel2: true,
      ),
    );

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
      SnackBarHelper.show(verifySubscriptionModel.message);
    }
  }

  setUser(UserModel userModel) async {
    Map<String, dynamic> data = {"id": userModel.id.toString(), "firstName": userModel.firstName, "lastName": userModel.lastName};

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.setUser, data);
    LoadingPage.close();

    SetUserModel setUserModel = SetUserModel.fromJson(resp);

    if (setUserModel.responseCode == 200) {
      setUserData.value = setUserModel.data!;
      totalSpinCount.value = ((setUserData.value.spinCount ?? 0) + (setUserData.value.referralSpins ?? 0)) as int;
      setUserData.value.setEarnedAmount = ((setUserData.value.earnedAmount ?? 0) * 100).truncateToDouble() / 100;
      goalAmount.value = ((((setUserModel.data?.goal ?? 0.0) as int) * 100).truncate() / 100) as int;
      extraCashStatus();
    } else {
      SnackBarHelper.show(setUserModel.message);
    }
    return;
  }

  extraCashStatus() async {
    var resp = await ApiCall.get(UrlApi.extraCashStatus);

    SettingsModel settingsModel = SettingsModel.fromJson(resp);

    if (settingsModel.responseCode == 200) {
      showExtraCash.value = settingsModel.data ?? false;
    }
  }

  onRankClick() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getRankList);

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

    InvitationModel invitationModel = InvitationModel.fromJson(resp);

    if (invitationModel.responseCode == 200) {
      InvitationListDialogComponent.show(
        invitationDataList: invitationModel.data ?? [],
        onRemind: onInviteForSpins,
      );
    }
  }

  onCashOut() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getProfile);

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

    WithdrawRequestModel withdrawRequestModel = WithdrawRequestModel.fromJson(resp);

    if (withdrawRequestModel.responseCode == 200) {
      WithdrawHistoryDialogComponent.show(withdrawRequestDataList: withdrawRequestModel.data ?? []);
    }
  }

  onWithdraw() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.cashOutRequest);
    LoadingPage.close();

    CashOutModel cashOutModel = CashOutModel.fromJson(resp);

    if (cashOutModel.responseCode == 200) {
      Get.back();
      setUserData.value.setEarnedAmount = ((cashOutModel.data?.earnedAmount ?? 0) * 100).truncateToDouble() / 100;
      setUserData.refresh();
      onCashOut();
      SnackBarHelper.show(cashOutModel.message ?? "", maxWidth: 280);
    } else {
      SnackBarHelper.show(cashOutModel.message ?? "");
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

  onSaveAccountInfo({bool showCashOut = true}) async {
    nameController.text = nameController.text.trim();
    upiController.text = upiController.text.trim();
    mobileNumberController.text = mobileNumberController.text.trim();

    if (!(RegexHelper.nameRegex.hasMatch(nameController.text))) {
      SnackBarHelper.show("Enter valid name", maxWidth: 180);
      return;
    } else if (!(RegexHelper.upiIdRegex.hasMatch(upiController.text))) {
      SnackBarHelper.show("Enter valid UPI ID", maxWidth: 180);
      return;
    } else if (!(RegexHelper.mobileRegex.hasMatch(mobileNumberController.text))) {
      SnackBarHelper.show("Enter valid mobile number");
      return;
    }

    Map<String, dynamic> data = {"upiId": upiController.text, "phoneNumber": mobileNumberController.text, "accountHolderName": nameController.text};

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.addUpiDetails, data);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      Get.back();
      if (showCashOut) {
        onCashOut();
      }
    } else {
      SnackBarHelper.show(responseModel.message ?? "");
    }
  }

  RxBool showConfetti = false.obs;
  Future<void> onSpin(int index) async {
    showConfetti.value = false;

    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getSpin);
    LoadingPage.close();

    SpinModel spinModel = SpinModel.fromJson(resp);

    if (spinModel.responseCode == 200) {
      SpinWinAmountDialogComponent.show(
        amount: ((spinModel.data?.spinAmount ?? 0) * 100).truncateToDouble() / 100,
        scratcherKey: scratchKey,
        onScratched: onScratched,
        showConfetti: showConfetti,
        coverImage: cardsList[index],
        revealImage: "assets/images/team${getRandomTeamNumber()}.png",
      );
      cardsList.removeAt(index);
      cardsList.add(getCoverImage());
      // SpinWinAmountDialogComponent.show(amount: ((spinModel.data?.spinAmount ?? 0) * 100).truncateToDouble() / 100, scratcherKey: scratchKey, onScratched: onScratched, showConfetti: showConfetti);

      Future.delayed(2.seconds, () {
        totalSpinCount.value = ((spinModel.data?.spinCount ?? 0) + (spinModel.data?.referralSpins ?? 0)) as int;
        setUserData.value.setEarnedAmount = ((spinModel.data?.earnedAmount ?? 0) * 100).truncateToDouble() / 100;
        setUserData.value.setSpinCount = spinModel.data?.spinCount ?? 0;
        setUserData.value.setReferralSpins = spinModel.data?.referralSpins ?? 0;
        setUserData.refresh();

        goalAmount.value = ((((spinModel.data?.goal ?? 0.0) as int) * 100).truncate() / 100) as int;
      });
    } else {
      if (totalSpinCount.value <= 0) {
        inviteForSpin();
        return;
      }
    }
  }

  void onScratched() {
    print("scratched");
    scratchKey.currentState?.reveal();
    showConfetti.value = true;
  }

  inviteForSpin() {
    InviteDialogComponent.show(onClick: onContinueToGetMoreSpin, setUserData: setUserData.value, goalAmount: goalAmount.value);
  }

  getMoreRewards() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getRewardsList);
    LoadingPage.close();

    RewardsModel rewardsModel = RewardsModel.fromJson(resp);

    if (rewardsModel.responseCode == 200) {
      RewardsDialogComponent.show(
        rewardsModel: rewardsModel,
        inviteStatus: inviteStatus,
        cashOutRequest: rewardCashOut,
        inviteReward: inviteRewards,
      );
    } else {
      SnackBarHelper.show(rewardsModel.message);
    }
  }

  int inviteStatus(int index, num totalReferralCount, List<ReferralSystemData> referralData) {
    int prevReferralCount = 0;
    for (int i = 0; i <= index; i++) {
      prevReferralCount += referralData[i].referralCount as int;
    }
    if ((totalReferralCount - prevReferralCount) > 0) {
      return referralData[index].referralCount as int;
    } else {
      int prevReferralCount2 = 0;
      for (int i = 0; i < index; i++) {
        prevReferralCount2 += referralData[i].referralCount as int;
      }
      if ((totalReferralCount - prevReferralCount2) > 0) {
        return (totalReferralCount - prevReferralCount2) as int;
      } else {
        return 0;
      }
    }
  }

  Future<void> rewardCashOut(int amount) async {
    LoadingPage.show();
    var resp = await ApiCall.get("${UrlApi.rewardCashOut}/$amount");
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      SnackBarHelper.show(responseModel.message);
      Future.delayed(
        200.milliseconds,
        () => Get.back(),
      );
    } else if (responseModel.responseCode == 502) {
      SnackBarHelper.show(responseModel.message);
      AccountInfoDialogComponent.show(
        nameController: nameController,
        upiController: upiController,
        mobileNumberController: mobileNumberController,
        onBack: () => Get.back(),
        onSave: () => onSaveAccountInfo(showCashOut: false),
      );
    } else {
      SnackBarHelper.show(responseModel.message);
    }
  }

  void inviteRewards() {
    String telegramLink =
        "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} %0A%0A🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 %0AClick URL and play with me!%0A%0A💰Let's stike it rich together!💰";

    html.window.open(telegramLink, '_blank');
  }

  onContinueToGetMoreSpin() {
    Get.back();
    String telegramLink =
        "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} %0A%0A🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 %0AClick URL and play with me!%0A%0A💰Let's stike it rich together!💰";

    html.window.open(telegramLink, '_blank');
  }

  onInviteForSpins() {
    String telegramLink =
        "https://t.me/share/url?url=https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} %0A%0A🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 %0AClick URL and play with me!%0A%0A💰Let's stike it rich together!💰";

    html.window.open(telegramLink, '_blank');
  }

  onCopyClick() {
    html.window.navigator.clipboard
        ?.writeText(
            "https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} \n\n🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 \nClick URL and play with me!\n\n💰Let's stike it rich together!💰")
        .then((_) {
      SnackBarHelper.show("Copied to Clipboard");
    }).catchError((e) {
      print("Failed to copy text to clipboard: $e");
    });
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
    String message =
        "https://t.me/Wheel24Bot?start=${setUserData.value.referralCode} \n\n🎁I've won ₹${setUserData.value.earnedAmount} from this Game!🎁 \nClick URL and play with me!\n\n💰Let's stike it rich together!💰";

    if (index == 0) {
      final String whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
      js.context.callMethod('open', [whatsappUrl, '_blank']);
    } else if (index == 1) {
      final String twitterUrl = 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}';
      js.context.callMethod('open', [twitterUrl, '_blank']);
    } else if (index == 2) {
      final String facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(message)}';
      js.context.callMethod('open', [facebookUrl, '_blank']);
    } else {
      html.window.navigator
          .share({
            'title': "Wheel24",
            'text': "Wheel24",
            'url': message,
          })
          .then((_) {})
          .catchError((e) {
            print("Error sharing content: $e");
          });
    }
  }

  Future<void> onExtraTaskClick() async {
    taskDataList.clear();
    LoadingPage.show();
    bool isListLoaded = await getTaskListData();
    bool isDailyReward = await getDailyRewards();
    bool isProfileData = await updateProfileData();
    LoadingPage.close();
    if (!(isListLoaded && isDailyReward && isProfileData)) {
      return;
    }
    totalDiamond.value = (setUserData.value.diamondsEarned ?? 0) as int;
    ExtraTaskDialogComponent.show(
      totalDiamond: totalDiamond,
      taskList: taskDataList,
      onInviteForSpin: onInviteForSpins,
      onRedeemSpin: onRedeemSpin,
      onDetailsClick: onTaskDetailsClick,
      onTaskGoClick: onTaskGoClick,
      onTaskClaimClick: onClaimTaskRewardClick,
      activeTimerIndexList: activeTimerIndexList,
      remainingTimes: remainingTimes,
      dailyReward: dailyRewardsData,
    );
  }

  Future<bool> updateProfileData() async {
    var resp = await ApiCall.get(UrlApi.getProfile);
    MyProfileModel myProfileModel = MyProfileModel.fromJson(resp);
    if (myProfileModel.responseCode == 200) {
      setUserData.value.setDiamondsEarned = myProfileModel.data?.diamondsEarned ?? 0;
      setUserData.value.setSpinCount = myProfileModel.data?.spinCount ?? 0;
      setUserData.value.setReferralSpins = myProfileModel.data?.referralSpins ?? 0;
      totalSpinCount.value = ((myProfileModel.data?.spinCount ?? 0) + (myProfileModel.data?.referralSpins ?? 0)) as int;
      return true;
    } else {
      SnackBarHelper.show(myProfileModel.message);
    }
    return false;
  }

  Future<bool> getDailyRewards() async {
    var resp = await ApiCall.get(UrlApi.getDailyRewards);

    DailyRewardsModel dailyRewardsModel = DailyRewardsModel.fromJson(resp);

    if (dailyRewardsModel.responseCode == 200) {
      dailyRewardsData.value = dailyRewardsModel.data ?? DailyRewardsData();
      return true;
    } else {
      SnackBarHelper.show(dailyRewardsModel.message);
    }
    return false;
  }

  Future<bool> getTaskListData() async {
    var resp = await ApiCall.get(UrlApi.getTasks);

    TaskListModel taskListModel = TaskListModel.fromJson(resp);

    if (taskListModel.responseCode == 200) {
      taskDataList.clear();
      taskDataList.addAll(taskListModel.data ?? []);
      return true;
    } else {
      SnackBarHelper.show(taskListModel.message);
    }
    return false;
  }

  Future<void> onRedeemSpin() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.redeemTaskDiamond);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      Get.back();
      DiamondToSpinDialogComponent.show(spinCount: ((setUserData.value.diamondsEarned ?? 0) / 1000).toInt());
      await updateProfileData();
      Future.delayed(1.seconds, () => Get.back());
    } else {
      SnackBarHelper.show(responseModel.message);
    }
    return;
  }

  Future<void> onTaskDetailsClick() async {
    LoadingPage.show();
    var resp = await ApiCall.get(UrlApi.getTaskHistory);
    LoadingPage.close();

    TaskRedeemHistoryModel taskRedeemHistoryModel = TaskRedeemHistoryModel.fromJson(resp);

    if (taskRedeemHistoryModel.responseCode == 200) {
      TaskRedeemHistoryDialogComponent.show(
        redeemList: taskRedeemHistoryModel.data ?? [],
      );
    } else {
      SnackBarHelper.show(taskRedeemHistoryModel.message);
    }
    return;
  }

  Future<void> onTaskGoClick(int index) async {
    if (taskDataList[index].type == 1) {
      String telegramLink = taskDataList[index].destinationLink ?? "";

      html.window.open(telegramLink, '_blank');
    } else if (taskDataList[index].type == 2) {
      uploadedProofFile.value = "";
      UploadProofDialogComponent.show(
        index: index,
        task: taskDataList[index],
        uploadedFile: uploadedProofFile,
        onVisitWebsite: onVisitWebsite,
        onUploadFile: pickProofFile,
        onConfirm: onConfirmProofFileSubmit,
      );
      return;
    } else if (taskDataList[index].type == 3) {
      String link = taskDataList[index].destinationLink ?? "";

      html.window.open(link, '_blank');
    } else if (taskDataList[index].type == 5) {
      onInviteForSpins();
    }

    initiateTaskReward(index);

    return;
  }

  Future<void> initiateTaskReward(int index, {String proofFile = ""}) async {
    Map<String, dynamic> data = {"taskId": taskDataList[index].id ?? ""};

    if (proofFile != "") {
      data["proofFile"] = uploadedProofFile.value;
    }
    var resp = await ApiCall.post(UrlApi.initiateTaskReward, data);

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      if (taskDataList[index].type != 3) {
        taskDataList[index].setIsInitiated = true;
        taskDataList.refresh();
      } else {
        if (taskDataList[index].isInitiated ?? false) {
          return;
        }
        activeTimerIndexList.add(index);
        activeTimerIndexList.refresh();
        startTimer(index, (taskDataList[index].claimDuration ?? 0) as int);
      }
    } else {
      SnackBarHelper.show(responseModel.message);
    }
  }

  void onClaimTaskRewardClick(int index) {
    if (taskDataList[index].type == 1) {
      verifyTaskSubscription(taskDataList[index].channelUserName ?? "", taskDataList[index].id ?? "", (taskDataList[index].diamonds ?? 0) as int);
    } else {
      claimTask(taskDataList[index].id ?? "", (taskDataList[index].diamonds ?? 0) as int);
    }
  }

  Future<void> verifyTaskSubscription(String channelName, String id, int diamondCount) async {
    Map<String, dynamic> data = {"channel": channelName};
    LoadingPage.show();
    var resp = await ApiCall.postWithoutEncryption("${UrlApi.verifyTaskSubscription}/${setUserData.value.telegramId}", data);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      if (responseModel.data) {
        claimTask(id, diamondCount);
      } else {
        SnackBarHelper.show("Please join the channel first");
      }
    } else {
      SnackBarHelper.show(responseModel.message);
    }
    return;
  }

  Future<void> claimTask(String taskId, int diamondCount) async {
    Map<String, dynamic> data = {"taskId": taskId};

    LoadingPage.show();
    var resp = await ApiCall.post(UrlApi.claimTaskReward, data);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(resp);

    if (responseModel.responseCode == 200) {
      setUserData.value.setDiamondsEarned = responseModel.data ?? 0;
      totalDiamond.value = setUserData.value.diamondsEarned as int;
      ClaimDiamondDialogComponent.show(diamondCount: diamondCount);
      await getTaskListData();
      Future.delayed(500.milliseconds, () => Get.back());
    } else {
      SnackBarHelper.show(responseModel.message);
    }
    return;
  }

  void pickProofFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((e) async {
          final fileBytes = reader.result as Uint8List;

          final imageUrl = await getImageUrl(file.name, fileBytes);
          if (imageUrl != null) {
            uploadedProofFile.value = imageUrl;
          }
        });
      }
    });
  }

  Future<String?> getImageUrl(String fileName, Uint8List fileBytes) async {
    var multipartFile = dio.MultipartFile.fromBytes(
      fileBytes,
      filename: fileName,
      contentType: http.MediaType('image', fileName.split('.').last),
    );

    var imageData = {
      "image": multipartFile,
    };

    LoadingPage.show();
    var res = await ApiCall.postForm(UrlApi.imageUpload, imageData);
    LoadingPage.close();

    ResponseModel responseModel = ResponseModel.fromJson(res);

    if (responseModel.responseCode == 200) {
      return responseModel.data;
    } else {
      SnackBarHelper.show(responseModel.message);
      return null;
    }
  }

  onVisitWebsite(String url) {
    html.window.open(url, '_blank');
  }

  void onConfirmProofFileSubmit(int index) {
    if (uploadedProofFile.value == "") {
      SnackBarHelper.show("Please upload a proof screenshot");
      return;
    }

    Get.back();
    initiateTaskReward(index, proofFile: uploadedProofFile.value);
  }

  void startTimer(int index, int duration) {
    if (remainingTimes.length <= index) {
      remainingTimes.addAll(List.filled(index - remainingTimes.length + 1, 0));
    }

    remainingTimes[index] = duration;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimes[index] <= 0) {
        timer.cancel();
        taskDataList[index].setIsInitiated = true;
        taskDataList.refresh();
        activeTimerIndexList.remove(index);
        activeTimerIndexList.refresh();
      } else {
        remainingTimes[index]--;
        update();
      }
    });
  }

  String getCoverImage() {
    int randomNumber = Random().nextInt(4) + 1;
    return "assets/images/cover$randomNumber.png";
  }

  int getRandomTeamNumber() {
    return Random().nextInt(10) + 1;
  }
}
