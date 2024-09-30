import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<double> sectors = [100, 20, 10, 50, 60];
  int randomSectorIndex = -1;
  List<double> sectorRadians = [];
  RxDouble angle = 0.0.obs;

  bool spinning = false;
  double earnedValue = 0;
  double totalEarning = 0;
  int spins = 0;

  math.Random random = math.Random();

  late AnimationController controller;
  late Animation<double> animation;

  HomeController() {
    generateSectorRadians();
    controller = AnimationController(vsync: this, duration: 3600.milliseconds);

    // the tween
    Tween<double> tween = Tween<double>(begin: 0, end: 1);

    // the curve behavior
    CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // animation
    animation = tween.animate(curve);

    controller.addListener(() {
      recordStats();
      spinning = false;
    },);
  }

  void generateSectorRadians() {
    double sectorRadian =
        2 * math.pi / sectors.length; // i.e. 360 degrees = 2xpi

    for (int i = 0; i < sectors.length; i++) {
      sectorRadians.add((i + 1) * sectorRadian);
    }
  }

  void recordStats() {
    earnedValue = sectors[sectors.length - (randomSectorIndex+1)];
    totalEarning = totalEarning + earnedValue;
    spins = spins + 1;
  }


  void spin() {
    print("spinning");
    if(!spinning) {
      randomSectorIndex = random.nextInt(sectors.length);
      double randomRadian = generateRandomRadianToSpin();
      controller.reset();
      angle.value = randomRadian;
      controller.forward();
      spinning = true;
    }
  }

  double generateRandomRadianToSpin() {
    return (2 * math.pi * sectors.length) + sectorRadians[randomSectorIndex];
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}
