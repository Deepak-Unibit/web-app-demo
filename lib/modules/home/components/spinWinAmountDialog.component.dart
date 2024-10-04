import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';

import '../../../helper/lottie.helper.dart';
import '../../../utils/assets.util.dart';

class SpinWinAmountDialogComponent {
  static show({required num amount}) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black.withOpacity(0.25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            child: Stack(
              alignment: Alignment.center,
              children: [
                LottieHelper.lottie(
                  animationAsset: AssetsUtil.getConfettiLottie(),
                  repeat: false,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Congratulations! You Get ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: " ₹ ${amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LottieHelper.lottie(
                      animationAsset: AssetsUtil.getRupeeLottie(),
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "₹ ${amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.primaryFixed,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SecondaryButtonComponent(
                      text: "GO ON!",
                      onClick: ()=>Get.back(),
                      height: 35,
                      width: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
