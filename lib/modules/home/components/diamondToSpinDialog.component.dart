import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.util.dart';

class DiamondToSpinDialogComponent {
  static show({
    required int spinCount,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsUtil.getDiamond(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      ">>",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      AssetsUtil.getScratchCard(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "You've got $spinCount Scratch Card!",
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