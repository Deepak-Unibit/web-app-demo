import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';

import '../../../helper/lottie.helper.dart';
import '../../../utils/assets.util.dart';

class SpinWinAmountDialogComponent {
  static show({required num amount, required Function onScratched, required Key scratcherKey, required RxBool showConfetti}) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Scratcher(
                  key: scratcherKey,
                  brushSize: 30,
                  threshold: 30,
                  image: Image.asset("assets/images/cover1.png"),
                  onChange: (value) {},
                  onThreshold: () => onScratched(),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        "assets/images/csk.png",
                        height: 200,
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            text: "₹ ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: context.theme.colorScheme.secondaryFixed,
                            ),
                            children: [
                              TextSpan(
                                text: "$amount",
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                            () => showConfetti.value
                            ? LottieHelper.lottie(
                          animationAsset: AssetsUtil.getConfettiLottie(),
                          repeat: true,
                        )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => showConfetti.value
                      ? SecondaryButtonComponent(
                          text: "GO ON!",
                          onClick: () => Get.back(),
                          height: 35,
                          width: 150,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
