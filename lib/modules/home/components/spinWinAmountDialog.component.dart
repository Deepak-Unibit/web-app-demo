import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';
import '../../../helper/lottie.helper.dart';
import '../../../utils/assets.util.dart';

class SpinWinAmountDialogComponent {
  static show({
    required num amount,
    required Function onScratched,
    required Key scratcherKey,
    required RxBool showConfetti,
    required String coverImage,
    required String revealImage,
  }) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black.withOpacity(0.25),
        child: PopScope(
          canPop: false,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Scratcher(
                      key: scratcherKey,
                      brushSize: 50,
                      threshold: 30,
                      image: Image.asset(coverImage),
                      onChange: (value) {},
                      onThreshold: () => onScratched(),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            revealImage,
                            height: 200,
                            width: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: RichText(
                              text: TextSpan(
                                text: "₹ ",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: context.theme.colorScheme.surface,
                                ),
                                children: [
                                  TextSpan(
                                    text: "$amount",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
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
                                    repeat: false,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => showConfetti.value
                        ? MaterialButton(
                            onPressed: () => Get.back(),
                            minWidth: 0,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    context.theme.colorScheme.secondary,
                                    context.theme.colorScheme.scrim,
                                  ],
                                ),
                                border: Border.all(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LottieHelper.lottie(
                                    animationAsset: AssetsUtil.getRupeeLottie(),
                                    repeat: true,
                                    height: 35,
                                    width: 35,
                                  ),
                                  Text(
                                    "COLLECT",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: context.theme.colorScheme.onSurface,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
