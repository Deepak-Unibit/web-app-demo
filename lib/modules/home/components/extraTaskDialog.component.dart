import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:web_app_demo/models/dailyRewards.model.dart';
import 'package:web_app_demo/models/taskList.model.dart';
import '../../../utils/assets.util.dart';

class ExtraTaskDialogComponent {
  static show({
    required RxInt totalDiamond,
    required RxList<TaskListData> taskList,
    required Function onInviteForSpin,
    required Function onRedeemSpin,
    required Function onDetailsClick,
    required Function onTaskGoClick,
    required Function onTaskClaimClick,
    required RxList<int> activeTimerIndexList,
    required RxList<int> remainingTimes,
    required Rx<DailyRewardsData> dailyReward,
  }) {
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
                      onPressed: () => onDetailsClick(),
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
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 5),
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
                          Obx(
                            () => Text(
                              "${totalDiamond.value}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Obx(
                                () => TaskButtonComponent(
                                  text: "Redeem Spin",
                                  onClick: totalDiamond.value >= 1000 ? () => onRedeemSpin() : () {},
                                  height: 30,
                                  width: 120,
                                  startColor: totalDiamond.value >= 1000 ? context.theme.colorScheme.surfaceContainerLow : context.theme.colorScheme.onSurface.withOpacity(0.65),
                                  endColor: totalDiamond.value >= 1000 ? context.theme.colorScheme.surfaceContainerHigh : context.theme.colorScheme.onSurfaceVariant.withOpacity(0.75),
                                ),
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
                        height: 160,
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
                        child: true
                            ? GridView(
                                shrinkWrap: true,
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 75,
                                  mainAxisExtent: 60,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                children: [
                                  DailyRewardComponent(day: 1, diamond: dailyReward.value.dailyReward?.day1 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 1),
                                  DailyRewardComponent(day: 2, diamond: dailyReward.value.dailyReward?.day2 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 2),
                                  DailyRewardComponent(day: 3, diamond: dailyReward.value.dailyReward?.day3 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 3),
                                  DailyRewardComponent(day: 4, diamond: dailyReward.value.dailyReward?.day4 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 4),
                                  DailyRewardComponent(day: 5, diamond: dailyReward.value.dailyReward?.day5 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 5),
                                  DailyRewardComponent(day: 6, diamond: dailyReward.value.dailyReward?.day6 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 6),
                                  DailyRewardComponent(day: 7, diamond: dailyReward.value.dailyReward?.day7 ?? 0, isCompleted: ((dailyReward.value.dailyRewardDay ?? 0) - 1) >= 7),
                                ],
                              )
                            : Column(
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
                          color: const Color(0xFF8f00ff).withOpacity(0.75),
                          border: Border.all(color: context.theme.colorScheme.onSurfaceVariant),
                        ),
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
                              onClick: () => onInviteForSpin(),
                              height: 30,
                              width: 120,
                              startColor: context.theme.colorScheme.surfaceContainerLow,
                              endColor: context.theme.colorScheme.surfaceContainerHigh,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Task List",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: taskList.length,
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
                                ImageNetwork(
                                  image: taskList[index].icon ?? "",
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
                                      taskList[index].title ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: context.theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => activeTimerIndexList.contains(index)
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Text(
                                            "Verifying in ${remainingTimes[index] ~/ 60}:${(remainingTimes[index] % 60) < 10 ? "0${remainingTimes[index] % 60}" : remainingTimes[index] % 60}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: context.theme.colorScheme.primaryFixed,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Column(
                                  children: [
                                    TaskButtonComponent(
                                      text: "GO",
                                      onClick: () => onTaskGoClick(index),
                                      height: 25,
                                      width: 80,
                                      startColor: context.theme.colorScheme.primaryFixed,
                                      endColor: context.theme.colorScheme.secondaryFixed,
                                    ),
                                    const SizedBox(height: 3),
                                    (taskList[index].isCompleted ?? false) && (taskList[index].type != 5)
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                AssetsUtil.getDiamond(),
                                                height: 18,
                                                width: 18,
                                              ),
                                              Text(
                                                "+${taskList[index].diamonds ?? 0}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: context.theme.colorScheme.onSurface,
                                                  height: 1,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              const SizedBox(width: 3),
                                              Icon(
                                                Icons.check_circle_rounded,
                                                size: 15,
                                                color: context.theme.colorScheme.scrim,
                                              ),
                                            ],
                                          )
                                        : TaskButtonComponent(
                                            text: "+${taskList[index].diamonds ?? 0}",
                                            showDiamond: true,
                                            onClick: ((taskList[index].isInitiated ?? false) && !(activeTimerIndexList.contains(index))) ? () => onTaskClaimClick(index) : () {},
                                            height: 25,
                                            width: 80,
                                            startColor: ((taskList[index].isInitiated ?? false) && !(activeTimerIndexList.contains(index)))
                                                ? context.theme.colorScheme.scrim
                                                : context.theme.colorScheme.onSurfaceVariant,
                                            endColor: ((taskList[index].isInitiated ?? false) && !(activeTimerIndexList.contains(index)))
                                                ? context.theme.colorScheme.scrim
                                                : context.theme.colorScheme.onSurfaceVariant,
                                          ),
                                  ],
                                ),
                              ],
                            ),
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

class DailyRewardComponent extends StatelessWidget {
  const DailyRewardComponent({
    super.key,
    required this.day,
    required this.diamond,
    required this.isCompleted,
  });

  final int day;
  final num diamond;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            context.theme.colorScheme.surfaceContainerLow,
            context.theme.colorScheme.surfaceContainerHigh,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Day $day",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsUtil.getDiamond(),
                height: 13,
                width: 13,
              ),
              const SizedBox(width: 3),
              Text(
                "$diamond",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: context.theme.colorScheme.onSurface,
                ),
              ),
              if (day == 7) ...[
                const SizedBox(width: 3),
                Image.asset(
                  AssetsUtil.getSpinCard(),
                  height: 13,
                  width: 13,
                ),
                const SizedBox(width: 3),
                Text(
                  "1",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
          isCompleted
              ? Icon(
                  Icons.check_circle_rounded,
                  size: 15,
                  color: context.theme.colorScheme.scrim,
                )
              : const SizedBox.shrink(),
        ],
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
                fontSize: 13,
                fontWeight: FontWeight.w600,
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
