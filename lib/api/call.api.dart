import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../helper/encryption.helper.dart';
import '../models/response.model.dart';
import 'app.const.dart';

final dio = Dio();

class ApiCall {
  static void configureDio() {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['app-id'] = AppConst.appId;
  }

  static void updateToken(String token) {
    dio.options.headers['x-access-token'] = token;
    AppConst.authToken = token;
  }

  static void forceLogout() {
    dio.options.headers.remove('x-access-token');
  }

  static post(String url, Map<String, dynamic> data) async {
    final Logger logger = Logger();
    try {
      String encryptedData = EncryptionHelper()
          .encryptAESCryptoJS(jsonEncode(data), AppConst.encryptionKey);
      final response = await dio
          .postUri(Uri.parse(url), data: {"data": encryptedData.toString()});
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      if (response.headers.value('Authorization') != null &&
          response.headers.value('Authorization') != '') {
        updateToken(response.headers.value('Authorization')!);
      }
      if (response.data["data"] == null) {
        return response.data;
      }
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static get(String url) async {
    final Logger logger = Logger();

    try {
      String urlPath = Uri.parse(url).path;
      if (Uri.parse(url).hasQuery) {
        urlPath = "$urlPath?${Uri.parse(url).query}";
      }
      String encryptedData = EncryptionHelper().encryptAESCryptoJS(urlPath, AppConst.encryptionKey);
      dio.options.headers['hash'] = encryptedData;
      final response = await dio.getUri(Uri.parse(url));
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": response.data['responseCode'],
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      // if (response.headers.value('Authorization') != null && response.headers.value('Authorization') != '') {
      //   updateToken(response.headers.value('Authorization')!);
      // }
      if (response.data["data"] == null) {
        return response.data;
      }
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      logger.e(url);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static put(String url, Map<String, dynamic> data) async {
    final Logger logger = Logger();
    try {
      String encryptedData = EncryptionHelper()
          .encryptAESCryptoJS(jsonEncode(data), AppConst.encryptionKey);
      final response =
          await dio.putUri(Uri.parse(url), data: {"data": encryptedData});
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      if (response.data["data"] == null) {
        return response.data;
      }
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static delete(String url) async {
    final Logger logger = Logger();
    try {
      String urlPath = Uri.parse(url).path;
      if (Uri.parse(url).hasQuery) {
        urlPath = "$urlPath?${Uri.parse(url).query}";
      }
      String encryptedData = EncryptionHelper()
          .encryptAESCryptoJS(urlPath, AppConst.encryptionKey);
      dio.options.headers['hash'] = encryptedData;
      final response = await dio.deleteUri(Uri.parse(url));
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      if (response.data["data"] == null) {
        return response.data;
      }
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static patch(String url, Map<String, dynamic> data) async {
    final Logger logger = Logger();
    try {
      String encryptedData = EncryptionHelper()
          .encryptAESCryptoJS(jsonEncode(data), AppConst.encryptionKey);
      final response =
          await dio.patchUri(Uri.parse(url), data: {"data": encryptedData});
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      if (response.data["data"] == null) {
        return response.data;
      }
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static postForm(String url, Map<String, dynamic> data) async {
    final Logger logger = Logger();
    try {
      final response = await dio.postUri(Uri.parse(url), data: FormData.fromMap(data));
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      if (response.data["data"] == null) {
        return response.data;
      }
      // response.data["data"] = DecryptUtils.decryptData(response.data["data"]);
      String decryptedData = EncryptionHelper()
          .decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(decryptedData);
      } catch (e) {
        response.data["data"] = decryptedData;
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }

  static getWithOutEncryption(String url) async {
    final Logger logger = Logger();

    try {
      String urlPath = Uri.parse(url).path;
      if (Uri.parse(url).hasQuery) {
        urlPath = "$urlPath?${Uri.parse(url).query}";
      }
      String encryptedData = EncryptionHelper().encryptAESCryptoJS(urlPath, AppConst.encryptionKey);
      dio.options.headers['hash'] = encryptedData;
      final response = await dio.getUri(Uri.parse(url));
      if (response.data['responseCode'] == 501) {
        ResponseModel responseModel = ResponseModel.fromJson({
          "status": "error",
          "message": response.data['message'],
          "responseCode": 500,
          "data": null,
        });
        forceLogout();
        return responseModel.toJson();
      }
      // if (response.headers.value('Authorization') != null && response.headers.value('Authorization') != '') {
      //   updateToken(response.headers.value('Authorization')!);
      // }
      if (response.data["data"] == null) {
        return response.data;
      }
      // String decryptedData = EncryptionHelper().decryptAESCryptoJS(response.data["data"], AppConst.encryptionKey);
      try {
        response.data["data"] = jsonDecode(response.data["data"]);
      } catch (e) {
        response.data["data"] = response.data["data"];
      }
      return response.data;
    } catch (e) {
      logger.e(e);
      logger.e(url);
      ResponseModel responseModel = ResponseModel.fromJson({
        "status": "error",
        "message": "Something went wrong",
        "responseCode": 500,
        "data": null,
      });
      return responseModel.toJson();
    }
  }
}
