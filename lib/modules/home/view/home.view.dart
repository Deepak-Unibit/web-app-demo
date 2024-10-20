import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:web_app_demo/modules/home/controller/home.controller.dart';
import 'dart:math' as math;

import 'package:web_app_demo/utils/assets.util.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: Get.height,
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 550,
              ),
              child: Image.asset(
                AssetsUtil.getLottie(),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildColumn(
                            context,
                            homeController.onRankClick,
                            AssetsUtil.getTrophy(),
                            "Rank",
                            context.theme.colorScheme.surfaceContainerHigh,
                            context.theme.colorScheme.surfaceContainerLow,
                          ),
                          buildColumn(
                            context,
                            homeController.onInvitation,
                            AssetsUtil.getInvitation(),
                            "Invitation",
                            context.theme.colorScheme.surfaceContainerHigh,
                            context.theme.colorScheme.surfaceContainerLow,
                          ),
                          buildColumn(
                            context,
                            homeController.onCashOut,
                            AssetsUtil.getCoin(),
                            "Cash Out",
                            context.theme.colorScheme.primaryFixed,
                            context.theme.colorScheme.secondaryFixed,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        Obx(
                          () => Text(
                            "₹${homeController.setUserData.value.earnedAmount ?? 0}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: context.theme.colorScheme.primaryFixed,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: Obx(
                        () => LinearProgressBar(
                          backgroundColor: context.theme.colorScheme.onSurface
                              .withOpacity(0.25),
                          progressColor:
                              context.theme.colorScheme.secondaryFixed,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          minHeight: 18,
                          maxSteps: homeController.goalAmount.value <= 0
                              ? 1
                              : homeController.goalAmount.value,
                          currentStep: (homeController
                                          .setUserData.value.earnedAmount ??
                                      0) >=
                                  homeController.goalAmount.value
                              ? homeController.goalAmount.value
                              : homeController.setUserData.value.earnedAmount
                                      ?.toInt() ??
                                  0,
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
                                fontStyle: FontStyle.italic),
                            children: [
                              TextSpan(
                                text:
                                    " ₹${(homeController.setUserData.value.earnedAmount ?? 0) >= homeController.goalAmount.value ? 0 : (homeController.goalAmount.value - (homeController.setUserData.value.earnedAmount ?? 0)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: context.theme.colorScheme.primaryFixed,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " to cash out ₹${homeController.goalAmount.value} !",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: homeController.turnAnimationController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: homeController
                                          .turnAnimationController.value *
                                      2 *
                                      math.pi,
                                  child: Image.asset(
                                    AssetsUtil.getTurn(),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Image.asset(
                                AssetsUtil.getBlackCircle(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(50),
                              child: Obx(
                                () => AnimatedBuilder(
                                  animation:
                                      homeController.animationController!,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: homeController
                                              .animationController!.value *
                                          2 *
                                          math.pi,
                                      child: RotationTransition(
                                        turns: AlwaysStoppedAnimation(
                                            (homeController
                                                    .selectedSector.value) /
                                                365),
                                        child: Image.asset(
                                          AssetsUtil.getBackground(),
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () => homeController.onSpin(),
                              minWidth: 0,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      AssetsUtil.getSpinButton(),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "${homeController.totalSpinCount.value}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: context
                                              .theme.colorScheme.onSurface,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Spins",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: context
                                            .theme.colorScheme.onSurface
                                            .withOpacity(0.5),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => homeController.totalSpinCount.value > 0 &&
                                      !homeController.isSpinning.value
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 22, left: 35),
                                      child: MaterialButton(
                                        onPressed: () =>
                                            homeController.onSpin(),
                                        minWidth: 0,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        child: AnimatedBuilder(
                                          animation: homeController
                                              .pointHandBgAnimationController,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle: homeController
                                                      .pointHandBgAnimationController
                                                      .value *
                                                  2 *
                                                  math.pi,
                                              child: Image.asset(
                                                AssetsUtil.getPointHandBg(),
                                                height: 45,
                                                width: 45,
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            Obx(
                              () => homeController.totalSpinCount.value > 0 &&
                                      !homeController.isSpinning.value
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 55, left: 70),
                                      child: MaterialButton(
                                        onPressed: () =>
                                            homeController.onSpin(),
                                        minWidth: 0,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        child: AnimatedBuilder(
                                          animation: homeController
                                              .pointHandBgAnimationController,
                                          builder: (context, child) {
                                            return Obx(
                                              () => Transform.scale(
                                                scale:
                                                    homeController.scale.value,
                                                child: Image.asset(
                                                  AssetsUtil.getPointHand(),
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Image.asset(
                            AssetsUtil.getMark(),
                            height: 42,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildColumn2(
                                  context,
                                  homeController.inviteForSpin,
                                  AssetsUtil.getSpinCard(),
                                  "+1 Spin",
                                  context
                                      .theme.colorScheme.surfaceContainerHigh,
                                  context
                                      .theme.colorScheme.surfaceContainerLow),
                              Obx(
                                () => homeController.showExtraCash.value
                                    ? buildColumn2(
                                        context,
                                        homeController.getMoreRewards,
                                        AssetsUtil.getChest(),
                                        "Extra Cash",
                                        context.theme.colorScheme
                                            .surfaceContainerHigh,
                                        context.theme.colorScheme
                                            .surfaceContainerLow,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MaterialButton(
                                      onPressed: () =>
                                          homeController.onInviteForSpins(),
                                      minWidth: 0,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      elevation: 0,
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              context.theme.colorScheme
                                                  .surfaceContainerHigh,
                                              context.theme.colorScheme
                                                  .surfaceContainerLow,
                                            ],
                                          ),
                                          border: Border.all(
                                            color: context
                                                .theme.colorScheme.onSurface
                                                .withOpacity(0.25),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AssetsUtil.getSpinCard(),
                                              height: 25,
                                              width: 40,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Invite for Spins!",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: context.theme.colorScheme
                                                    .onSurface,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  MaterialButton(
                                    onPressed: () =>
                                        homeController.onCopyClick(),
                                    minWidth: 0,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            context.theme.colorScheme
                                                .surfaceContainerHigh,
                                            context.theme.colorScheme
                                                .surfaceContainerLow,
                                          ],
                                        ),
                                        border: Border.all(
                                          color: context
                                              .theme.colorScheme.onSurface
                                              .withOpacity(0.25),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.copy,
                                        size: 18,
                                        color:
                                            context.theme.colorScheme.onSurface,
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
                                  onPressed: () =>
                                      homeController.onShareClick(0),
                                  minWidth: 0,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Image.asset(
                                    AssetsUtil.getWhatsappIcon(),
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                MaterialButton(
                                  onPressed: () =>
                                      homeController.onShareClick(1),
                                  minWidth: 0,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Image.asset(
                                    AssetsUtil.getXIcon(),
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                MaterialButton(
                                  onPressed: () =>
                                      homeController.onShareClick(2),
                                  minWidth: 0,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                        Obx(
                          () => homeController.totalSpinCount.value <= 0 &&
                                  !homeController.isSpinning.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 145, bottom: 38),
                                  child: MaterialButton(
                                    onPressed: () =>
                                        homeController.onInviteForSpins(),
                                    minWidth: 0,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: AnimatedBuilder(
                                      animation: homeController
                                          .pointHandBgAnimationController,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle: homeController
                                                  .pointHandBgAnimationController
                                                  .value *
                                              2 *
                                              math.pi,
                                          child: Image.asset(
                                            AssetsUtil.getPointHandBg(),
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Obx(
                          () => homeController.totalSpinCount.value <= 0 &&
                                  !homeController.isSpinning.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 178, bottom: 5),
                                  child: MaterialButton(
                                    onPressed: () =>
                                        homeController.onInviteForSpins(),
                                    minWidth: 0,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: AnimatedBuilder(
                                      animation: homeController
                                          .pointHandBgAnimationController,
                                      builder: (context, child) {
                                        return Obx(
                                          () => Transform.scale(
                                            scale: homeController.scale.value,
                                            child: Image.asset(
                                              AssetsUtil.getPointHand(),
                                              height: 45,
                                              width: 45,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
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
    );
  }

  MaterialButton buildColumn(BuildContext context, Function onClick,
      String image, String text, Color startColor, Color endColor) {
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
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5),
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
                  width: 1.5),
            ),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.onSurface,
                  height: 1),
            ),
          )
        ],
      ),
    );
  }

  MaterialButton buildColumn2(BuildContext context, Function onClick,
      String image, String text, Color startColor, Color endColor) {
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
              border: Border.all(
                  color: context.theme.colorScheme.onSurface.withOpacity(0.25),
                  width: 1.5),
            ),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.onSurface,
                  height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
