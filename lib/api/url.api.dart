import 'app.const.dart';

class UrlApi {
  static const String baseUrl = AppConst.baseUrl;
  static const String baseUrl2 = AppConst.baseUrl2;

  // Auth
  static const setUser = "$baseUrl/auth/set";
  static const getSpin = "$baseUrl/user/spin-wheel";
  static const verifySubscription = "$baseUrl2/verify-subscription";

  // Invitation
  static const getInvitationList = "$baseUrl/user/my-invitation-history";

  // Rank
  static const getRankList = "$baseUrl/user/ranks";
  static const getMyRank = "$baseUrl/user/my-rank";

  // Profile
  static const getProfile = "$baseUrl/user/my-profile";
  static const getWithdrawDetails = "$baseUrl/user/withdraw-details";
  static const addUpiDetails = "$baseUrl/user/upi-details";
  static const cashOutRequest = "$baseUrl/user/cash-out-request";
  static const getWithdrawList = "$baseUrl/user/withdraw-requests";

  // Rewards
  static const getRewardsList = "$baseUrl/user/cash-referral-details";
  static const rewardCashOut = "$baseUrl/user/referral-cash-out-request";
  static const extraCashStatus = "$baseUrl/user/show-extra-cash";

}
