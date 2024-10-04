import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';
import 'package:web_app_demo/utils/assets.util.dart';

class GetSpinDialogComponent {
  static show({required Function onJoinChannelClick, required Function onContinueClick, required String text, required int channel1Status, required int channel2Status}) {
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
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: context.theme.colorScheme.primaryFixed.withOpacity(0.25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsUtil.getSpinCard(),
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: "Join Channel & Get ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: "3",
                        style: TextStyle(
                          color: context.theme.colorScheme.primaryFixed,
                        ),
                      ),
                      const TextSpan(
                        text: " Spin!"
                      ),
                    ],
                  ),
                ),
                channel1Status!=2 ? const SizedBox(height: 20) : const SizedBox.shrink(),
                channel1Status!=2 ? SecondaryButtonComponent(
                  text: channel1Status==0 ? "Join Channel & Get Spin" : channel1Status==1 ? "Continue" : "",
                  onClick: channel1Status==0 ? ()=>onJoinChannelClick(0) : channel1Status==1 ? onContinueClick : (){},
                  height: 35,
                  width: double.infinity,
                ) : const SizedBox.shrink(),
                channel2Status!=2 ? const SizedBox(height: 20) : const SizedBox.shrink(),
                channel2Status!=2 ? SecondaryButtonComponent(
                  text: channel2Status==0 ? "Join Channel & Get Spin" : channel2Status==1 ? "Continue" : "",
                  onClick: channel2Status==0 ? ()=>onJoinChannelClick(1) : channel2Status==1 ? onContinueClick : (){},
                  height: 35,
                  width: double.infinity,
                ) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
