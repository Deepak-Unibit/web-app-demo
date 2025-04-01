import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:web_app_demo/modules/home/controller/home.controller.dart';
import 'package:web_app_demo/utils/assets.util.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsUtil.getBackground()),
              fit: BoxFit.fitWidth,
            ),
          ),
          constraints: const BoxConstraints(maxWidth: 450),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(
                        context,
                        homeController.onRankClick,
                        AssetsUtil.getRank(),
                      ),
                      buildButton(
                        context,
                        homeController.onInvitation,
                        AssetsUtil.getInvitation(),
                      ),
                      buildButton(
                        context,
                        homeController.onCashOut,
                        AssetsUtil.getCashOut(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsUtil.getTwoCoin(),
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            text: "₹ ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: context.theme.colorScheme.secondaryFixed,
                            ),
                            children: [
                              TextSpan(
                                text: "${homeController.setUserData.value.earnedAmount ?? 0}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Obx(
                      () => LinearProgressBar(
                        backgroundColor: context.theme.colorScheme.onSurface.withOpacity(0.25),
                        progressColor: context.theme.colorScheme.secondaryFixed,
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        minHeight: 18,
                        maxSteps: homeController.goalAmount.value <= 0 ? 1 : homeController.goalAmount.value,
                        currentStep: (homeController.setUserData.value.earnedAmount ?? 0) >= homeController.goalAmount.value
                            ? homeController.goalAmount.value
                            : homeController.setUserData.value.earnedAmount?.toInt() ?? 0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () => RichText(
                        text: TextSpan(
                          text: "Only ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.onSurface,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            TextSpan(
                              text: " ₹",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.primaryFixed,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(homeController.setUserData.value.earnedAmount ?? 0) >= homeController.goalAmount.value ? 0 : (homeController.goalAmount.value - (homeController.setUserData.value.earnedAmount ?? 0)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.primaryFixed,
                              ),
                            ),
                            const TextSpan(
                              text: " to cash out",
                            ),
                            TextSpan(
                              text: " ₹",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.primaryFixed,
                              ),
                            ),
                            TextSpan(
                              text: "${homeController.goalAmount.value}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.primaryFixed,
                              ),
                            ),
                            const TextSpan(
                              text: " !",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(
                        context,
                        homeController.onExtraTaskClick,
                        AssetsUtil.getExtraTask(),
                      ),
                      Obx(
                        () => homeController.showExtraCash.value
                            ? buildButton(
                                context,
                                homeController.getMoreRewards,
                                AssetsUtil.getExtraCash(),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Obx(
                    () => GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 150),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: 10.obs.value,
                      itemBuilder: (context, index) => MaterialButton(
                        onPressed: () => homeController.onSpin(),
                        minWidth: 0,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(
                                homeController.getCoverImage(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: MaterialButton(
                                onPressed: () => homeController.onInviteForSpins(),
                                minWidth: 0,
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                elevation: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        context.theme.colorScheme.primaryFixed,
                                        context.theme.colorScheme.secondaryFixed,
                                      ],
                                    ),
                                    border: Border.all(
                                      color: context.theme.colorScheme.onSurface.withOpacity(0.25),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    "Invite for Scratch Cards",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: context.theme.colorScheme.surface,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            MaterialButton(
                              onPressed: () => homeController.onCopyClick(),
                              minWidth: 0,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      context.theme.colorScheme.primaryFixed,
                                      context.theme.colorScheme.secondaryFixed,
                                    ],
                                  ),
                                  border: Border.all(
                                    color: context.theme.colorScheme.onSurface.withOpacity(0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.copy,
                                  size: 18,
                                  color: context.theme.colorScheme.surface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Share To:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 10),
                          MaterialButton(
                            onPressed: () => homeController.onShareClick(0),
                            minWidth: 0,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            child: Image.asset(
                              AssetsUtil.getWhatsappIcon(),
                              height: 22,
                              width: 22,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          MaterialButton(
                            onPressed: () => homeController.onShareClick(1),
                            minWidth: 0,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            child: Image.asset(
                              AssetsUtil.getXIcon(),
                              height: 22,
                              width: 22,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          MaterialButton(
                            onPressed: () => homeController.onShareClick(2),
                            minWidth: 0,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            child: Image.asset(
                              AssetsUtil.getFacebookIcon(),
                              height: 22,
                              width: 22,
                              fit: BoxFit.cover,
                            ),
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
      ),
    );
  }

  MaterialButton buildButton(BuildContext context, Function onClick, String image) {
    return MaterialButton(
      onPressed: () => onClick(),
      minWidth: 0,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Image.asset(
        image,
        height: 75,
        width: 93,
        fit: BoxFit.contain,
      ),
    );
  }

  MaterialButton buildColumn2(BuildContext context, Function onClick, String image, String text, Color startColor, Color endColor) {
    return MaterialButton(
      onPressed: () => onClick(),
      minWidth: 0,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 3),
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
              border: Border.all(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: context.theme.colorScheme.onSurface, height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
