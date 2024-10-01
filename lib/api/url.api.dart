import 'app.const.dart';

class UrlApi {
  static const String baseUrl = AppConst.baseUrl;

  //Auth
  static const sendOTP = "$baseUrl/primary/auth/login-otp";
  static const verifyOTP = "$baseUrl/primary/auth/verify-otp";
  static const logOut = "$baseUrl/primary/admin-service/admin/logout";

}
