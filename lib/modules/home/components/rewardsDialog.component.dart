import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '../../../models/rewards.model.dart';
import '../../../utils/assets.util.dart';

class RewardsDialogComponent {
  static show({required RewardsModel rewardsModel, required Function inviteStatus, required Function cashOutRequest, required Function inviteReward}) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsUtil.getTwoCoin(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Rewards",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Here are the rewards for your referrals:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Claim your rewards based on the number of referrals!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    itemCount: rewardsModel.data!.referralSystem!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: context.theme.colorScheme.onSurface,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AssetsUtil.getGiftBox(),
                            height: 55,
                            width: 55,
                            fit: BoxFit.contain,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 170),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${rewardsModel.data!.referralSystem?[index].referralCount} Referrals: ₹${rewardsModel.data!.referralSystem?[index].referralReward}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colorScheme.surface,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 120,
                                  child: LinearProgressBar(
                                    backgroundColor: context.theme.colorScheme.onSurfaceVariant.withOpacity(0.25),
                                    progressColor: context
                                        .theme.colorScheme.surfaceContainerHigh,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    minHeight: 12,
                                    maxSteps: (rewardsModel.data!.referralSystem![index].referralCount??0) as int,
                                    currentStep: inviteStatus(index, rewardsModel.data!.referralCountForCash, rewardsModel.data?.referralSystem!),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${inviteStatus(index, rewardsModel.data!.referralCountForCash, rewardsModel.data?.referralSystem!)}/${(rewardsModel.data!.referralSystem![index].referralCount??0)} Today",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: context
                                        .theme.colorScheme.onSurfaceVariant
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              RewardButtonComponent(
                                text: "Claim",
                                onClick: ()=>cashOutRequest(rewardsModel.data!.referralSystem![index].referralReward??0),
                                height: 25,
                                width: 49,
                                startColor: (rewardsModel.data?.cashClaimedCount??0)==index ? context.theme.colorScheme.primaryFixed : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                                endColor:(rewardsModel.data?.cashClaimedCount??0)==index ? context.theme.colorScheme.secondaryFixed : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                              ),
                              const SizedBox(height: 10),
                             RewardButtonComponent(
                                text: "Invite",
                                onClick: ()=>inviteReward(),
                                height: 25,
                                width: 49,
                                startColor: context.theme.colorScheme.scrim,
                                endColor: context.theme.colorScheme.scrim,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () => Get.back(),
                    minWidth: 0,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 150,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            context.theme.colorScheme.surfaceContainerLow,
                            context.theme.colorScheme.surfaceContainerHigh,
                          ],
                        ),
                        border: Border.all(
                            color: context.theme.colorScheme.onSurface
                                .withOpacity(0.25),
                            width: 1.5),
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.onSurface,
                          height: 1,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
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

class RewardButtonComponent extends StatelessWidget {
  const RewardButtonComponent({
    super.key,
    required this.text,
    required this.onClick,
    required this.height,
    required this.width,
    required this.startColor,
    required this.endColor,
  });

  final String text;
  final Function onClick;
  final double height;
  final double width;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onClick(),
      minWidth: 0,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              startColor,
              endColor,
            ],
          ),
          border: Border.all(
              color: context.theme.colorScheme.onSurface.withOpacity(0.25),
              width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.theme.colorScheme.onSurface,
            height: 1,
          ),
        ),
      ),
    );
  }
}
