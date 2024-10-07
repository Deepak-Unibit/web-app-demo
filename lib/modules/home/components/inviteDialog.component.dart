import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';

import '../../../models/setUser.model.dart';
import '../../../utils/assets.util.dart';


class InviteDialogComponent {
  static show({required Function onClick, required SetUserData setUserData, required int goalAmount}) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.black.withOpacity(0.25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: context.theme.colorScheme.primaryFixed.withOpacity(0.25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: MaterialButton(
                    onPressed: () => Get.back(),
                    minWidth: 0,
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    visualDensity: VisualDensity.compact,
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  "Invite To Get More Spins",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsUtil.getCoin(),
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                        "₹${setUserData.earnedAmount ?? 0}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: context.theme.colorScheme.primaryFixed,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: LinearProgressBar(
                      backgroundColor: context.theme.colorScheme.onSurface.withOpacity(0.25),
                      progressColor: context.theme.colorScheme.secondaryFixed,
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      minHeight: 18,
                      maxSteps: goalAmount<=0 ? 1 : goalAmount,
                      currentStep: (setUserData.earnedAmount ?? 0) >= goalAmount
                          ? goalAmount
                          : (setUserData.earnedAmount ?? 0).toInt(),
                    ),

                ),
                const SizedBox(height: 10),
                RichText(
                      text: TextSpan(
                        text: "Only ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.onSurface,
                            fontStyle: FontStyle.italic),
                        children: [
                          TextSpan(
                            text:
                      " ₹${(setUserData.earnedAmount??0) >= goalAmount ? 0 : (goalAmount - (setUserData.earnedAmount ?? 0)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.primaryFixed,
                            ),
                          ),
                           TextSpan(
                            text: " to cash out ₹$goalAmount !",
                          )
                        ],
                      ),
                    ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: SecondaryButtonComponent(
                    text: "Invite for Spins",
                    onClick: onClick,
                    height: 35,
                    width: double.infinity,
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