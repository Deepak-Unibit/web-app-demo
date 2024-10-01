import 'app.const.dart';

class UrlApi {
  static const String baseUrl = AppConst.baseUrl;

  //Auth
  static const setUser = "$baseUrl/auth/set";
  static const getSpin = "$baseUrl/user/spin-wheel";

}
