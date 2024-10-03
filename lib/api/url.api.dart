import 'app.const.dart';

class UrlApi {
  static const String baseUrl = AppConst.baseUrl;
  static const String baseUrl2 = "https://dev.fun11.in:8006";

  //Auth
  static const setUser = "$baseUrl/auth/set";
  static const getSpin = "$baseUrl/user/spin-wheel";
  static const verifySubscription = "$baseUrl2/verify-subscription";

}
