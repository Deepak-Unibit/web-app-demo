import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    print(homeController.animationController!.value * 2 * math.pi);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: Get.height,
                width: double.infinity,
                child: LottieHelper.lottie(animationAsset: AssetsUtil.getLottie()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildColumn(
                          context,
                          AssetsUtil.getTrophy(),
                          "Rank",
                        ),
                        buildColumn(
                          context,
                          AssetsUtil.getInvitation(),
                          "Invitation",
                        ),
                        buildColumn(
                          context,
                          AssetsUtil.getCoin(),
                          "Cash Out",
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsUtil.getCoin(), height: 30, width: 30, fit: BoxFit.contain,),
                        const SizedBox(width: 10),
                        Text(
                          "FF681274",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.primaryFixed
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.5,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Obx(
                            () => AnimatedBuilder(
                              animation: homeController.animationController!,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle:
                                      homeController.animationController!.value *
                                          2 *
                                          math.pi,
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(
                                        (homeController.selectedSector * 30) /
                                            360),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(500)),
                                        child: Image.asset(
                                            AssetsUtil.getBackground()),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 200),
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              size: 60,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () => homeController.onClick(),
                      color: Colors.green,
                      child: Text("Click"),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => Text("${homeController.selectedSector.value * 30}"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton buildColumn(BuildContext context, String image, String text) {
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
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color:
                    context.theme.colorScheme.surfaceContainer.withOpacity(0.8),
                border: Border.all(
                    color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                    width: 1.5)),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          )
        ],
      ),
    );
  }
}
