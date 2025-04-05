import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/lottie.helper.dart';
import '../../../utils/assets.util.dart';

class ExtraTaskCashOutDialogComponent {
  static show({
    required int amount,
  }) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black12.withOpacity(0.4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieHelper.lottie(
                  animationAsset: AssetsUtil.getRupeeLottie(),
                  repeat: true,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 5),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Withdraw request of ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: "₹$amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.secondaryFixed,
                        ),
                      ),
                      const TextSpan(
                        text: "\nsubmitted!",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
