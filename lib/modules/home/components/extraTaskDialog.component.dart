import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '../../../models/rewards.model.dart';
import '../../../utils/assets.util.dart';

class ExtraTaskDialogComponent {
  static show() {
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
                      AssetsUtil.getExtraTask(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "My Gems",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () => Get.back(),
                      minWidth: 0,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: 80,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                          border: Border.all(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSurface,
                                height: 1,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetsUtil.getDiamond(),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "700",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              TaskButtonComponent(
                                text: "Redeem Spin",
                                onClick: () {},
                                height: 30,
                                width: 120,
                                startColor: true ? context.theme.colorScheme.surfaceContainerLow : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                                endColor: true ? context.theme.colorScheme.surfaceContainerHigh : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                              ),
                              const SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  text: "(1000 ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: context.theme.colorScheme.onSurface,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Image.asset(
                                        AssetsUtil.getDiamond(),
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                    const TextSpan(text: " = 1 spin)"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: const EdgeInsets.only(top: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  context.theme.colorScheme.surfaceContainerHigh,
                                  context.theme.colorScheme.surfaceContainerLow,
                                ],
                              ),
                            ),
                            child: Text(
                              "Daily Rewards",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSecondaryFixedVariant,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              AssetsUtil.getLoop(),
                              height: 40,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                AssetsUtil.getLoop(),
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              context.theme.colorScheme.onSecondaryFixedVariant,
                              context.theme.colorScheme.onSurface,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsUtil.getDailyFinish(),
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Daily Rewards event is over.\nInvite friends to get more spin!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: context.theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Invitation Reward",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: context.theme.colorScheme.surfaceContainerLow.withOpacity(0.9),
                            border: Border.all(color: context.theme.colorScheme.onSurfaceVariant)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: context.theme.colorScheme.onSurface,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Image.asset(
                                      AssetsUtil.getInvitation(),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const TextSpan(text: " Invite 1 Friend = "),
                                  WidgetSpan(
                                    child: Image.asset(
                                      AssetsUtil.getSpinCard(),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const TextSpan(text: " 1 Spin"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TaskButtonComponent(
                              text: "Invite for Spin!",
                              onClick: () {},
                              height: 30,
                              width: 120,
                              startColor: true ? context.theme.colorScheme.surfaceContainerLow : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                              endColor: true ? context.theme.colorScheme.surfaceContainerHigh : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Task List",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            minWidth: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            visualDensity: VisualDensity.compact,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(10)), side: BorderSide(color: context.theme.colorScheme.onSecondaryFixedVariant.withOpacity(0.5))),
                            child: Icon(
                              Icons.refresh,
                              size: 20,
                              color: context.theme.colorScheme.onSecondaryFixedVariant,
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: 5,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: context.theme.colorScheme.onSurfaceVariant),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF8f00ff),
                                Color(0xFF560099),
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              const ImageNetwork(
                                image:
                                    "https://img.freepik.com/free-vector/bicycle-shop-logo-design-vector_53876-40626.jpg?t=st=1733142967~exp=1733146567~hmac=827a03765350a77a0758bcd8e5f90ef44227b22c7f3f0742f6eaf4e5c59fe5b4&w=826",
                                height: 45,
                                width: 45,
                                fitAndroidIos: BoxFit.contain,
                                fitWeb: BoxFitWeb.contain,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Register SocratesWeb3",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: context.theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  TaskButtonComponent(
                                    text: "GO",
                                    onClick: () {},
                                    height: 25,
                                    width: 65,
                                    startColor: context.theme.colorScheme.primaryFixed,
                                    endColor: context.theme.colorScheme.secondaryFixed,
                                  ),
                                  const SizedBox(height: 3),
                                  TaskButtonComponent(
                                    text: "+300",
                                    showDiamond: true,
                                    onClick: () {},
                                    height: 25,
                                    width: 65,
                                    startColor: context.theme.colorScheme.onSurfaceVariant,
                                    endColor: context.theme.colorScheme.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            context.theme.colorScheme.surfaceContainerLow,
                            context.theme.colorScheme.surfaceContainerHigh,
                          ],
                        ),
                        border: Border.all(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5),
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

class TaskButtonComponent extends StatelessWidget {
  const TaskButtonComponent({
    super.key,
    required this.text,
    required this.onClick,
    required this.height,
    required this.width,
    required this.startColor,
    required this.endColor,
    this.showDiamond = false,
  });

  final String text;
  final Function onClick;
  final double height;
  final double width;
  final Color startColor;
  final Color endColor;
  final bool showDiamond;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showDiamond
                ? Image.asset(
                    AssetsUtil.getDiamond(),
                    height: 18,
                    width: 18,
                  )
                : const SizedBox.shrink(),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.theme.colorScheme.onSurface,
                height: 1,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
