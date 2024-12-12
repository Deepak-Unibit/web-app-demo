import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/lottie.helper.dart';
import '../../../utils/assets.util.dart';

class ClaimDiamondDialogComponent {
  static show({
    required int diamondCount,
  }) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black12.withOpacity(0.4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AssetsUtil.getClaimDiamondLottie(),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    // LottieHelper.lottie(
                    //   animationAsset: AssetsUtil.getClaimDiamondLottie(),
                    //   height: 120,
                    //   width: 120,
                    // ),
                    Image.asset(
                      AssetsUtil.getDiamond(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "You've got $diamondCount Diamond!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onSurface,
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
