import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:web_app_demo/helper/lottie.helper.dart';
import 'package:web_app_demo/modules/home/controller/home.controller.dart';
import 'dart:math' as math;

import 'package:web_app_demo/utils/assets.util.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // final List<int> items = [100, 200, 300, 500, 1000, 2000];
  // final Get.Rx<BehaviorSubject<int>> selected = BehaviorSubject<int>().obs;

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
              child: Image.asset(AssetsUtil.getLottie(), width: double.infinity,),
              // child: LottieHelper.lottie(animationAsset: AssetsUtil.getLottie()),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                            AssetsUtil.getTrophy(),
                            "Rank",
                            context.theme.colorScheme.surfaceContainerHigh,
                            context.theme.colorScheme.surfaceContainerLow,
                          ),
                          buildColumn(
                            context,
                            AssetsUtil.getInvitation(),
                            "Invitation",
                            context.theme.colorScheme.surfaceContainerHigh,
                            context.theme.colorScheme.surfaceContainerLow,
                          ),
                          buildColumn(
                            context,
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
                        Text(
                          "₹544",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: context.theme.colorScheme.primaryFixed,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: LinearProgressBar(
                        backgroundColor: context.theme.colorScheme.onSurface
                            .withOpacity(0.25),
                        progressColor: context.theme.colorScheme.secondaryFixed,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        minHeight: 18,
                        maxSteps: 100,
                        currentStep: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Only ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: context.theme.colorScheme.onSurface,
                              fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                              text: " ₹13",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.primaryFixed,
                              ),
                            ),
                            const TextSpan(
                              text: " to cash out ₹100 !",
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: homeController.turnAnimationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle:
                                  homeController.turnAnimationController.value *
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
                              animation: homeController.animationController!,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: homeController
                                          .animationController!.value *
                                      2 *
                                      math.pi,
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(
                                        (homeController.selectedSector * 30) /
                                            360),
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
                          onPressed: () => homeController.onClick(),
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
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
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colorScheme.onSurface,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  "Spins",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: context.theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Get.width>400 ? 350 : (Get.width/2)+50),
                          child: Image.asset(AssetsUtil.getMark(), height: 45,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: [
                          Flexible(
                            child: MaterialButton(
                              onPressed: (){},
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
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        context
                                            .theme.colorScheme.surfaceContainerHigh,
                                        context
                                            .theme.colorScheme.surfaceContainerLow,
                                      ],
                                    ),
                                    border: Border.all(
                                      color: context.theme.colorScheme.onSurface
                                          .withOpacity(0.25),
                                      width: 1.5,
                                    )),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsUtil.getSpinCard(),
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Invite for Spins!",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              context.theme.colorScheme.onSurface,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          MaterialButton(
                            onPressed: (){},
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
                                    context.theme.colorScheme.surfaceContainerHigh,
                                    context.theme.colorScheme.surfaceContainerLow,
                                  ],
                                ),
                                border: Border.all(
                                  color: context.theme.colorScheme.onSurface
                                      .withOpacity(0.25),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.copy,
                                size: 18,
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  MaterialButton buildColumn(BuildContext context, String image, String text,
      Color startColor, Color endColor) {
    return MaterialButton(
      onPressed: () {},
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
}
