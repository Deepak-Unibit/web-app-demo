import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/modules/home/controller/home.controller.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // final List<int> items = [100, 200, 300, 500, 1000, 2000];
  // final Get.Rx<BehaviorSubject<int>> selected = BehaviorSubject<int>().obs;

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    print(homeController.animationController!.value * 2 * math.pi);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Fortune Wheel"),
            const SizedBox(height: 20),

            SizedBox(
              width: Get.width*0.8,
              child: Obx(
                () => AnimatedBuilder(
                  animation: homeController.animationController!,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: homeController.animationController!.value * 2 * math.pi,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(500)),
                          child: Image.asset('assets/images/spinningWheel.jpg'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            MaterialButton(onPressed: ()=>homeController.onClick(), child: Text("Click"),),

            // InkWell(
            //   onTap: () {
            //     homeController.spin();
            //   },
            //   child: AnimatedBuilder(
            //     animation: Listenable.merge([]),
            //     builder: (context, child) => Obx(
            //       () => Transform.rotate(
            //         angle: homeController.controller.value *
            //             homeController.angle.value,
            //         child: Container(
            //           height: 100,
            //           width: 100,
            //           margin: const EdgeInsets.all(20),
            //           decoration: const BoxDecoration(
            //             color: Colors.red,
            //             image: DecorationImage(
            //                 image:
            //                     AssetImage("assets/images/spinningWheel.jpg"),
            //                 fit: BoxFit.cover),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   height: 200,
            //   width: 200,
            //   child: Get.Obx(
            //     ()=> FortuneWheel(
            //         selected: selected.value.stream,
            //         animateFirst: false,
            //         rotationCount: 10,
            //         items: [
            //           for (int i = 0; i < items.length; i++) ...<FortuneItem>{
            //             FortuneItem(child: Text(items[i].toString())),
            //           },
            //         ],
            //         onAnimationEnd: () {
            //           print("animation end");
            //           // selected.value.close();
            //           selected.value = BehaviorSubject<int>();
            //         },
            //       ),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // MaterialButton(
            //   onPressed: () {
            //     int val = Fortune.randomInt(0, items.length);
            //     selected.value.add(val);
            //     print("onTap $val ${selected.value.stream.value}");
            //   },
            //   child: Container(
            //     height: 40,
            //     width: 120,
            //     color: Colors.red,
            //     child: const Center(
            //       child: Text("SPIN"),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
