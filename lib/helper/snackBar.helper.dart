import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void show(String? message, {double maxWidth = 250}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
     '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white.withOpacity(0.1),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
        titleText: const SizedBox.shrink(),
        messageText: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
        ),
        maxWidth: maxWidth,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 5),
    );
  }

  static void success(String? message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Success'.tr,
      message?.tr ?? 'Success'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }
}