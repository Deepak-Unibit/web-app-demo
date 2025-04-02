import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/helper/date.helper.dart';
import 'package:web_app_demo/models/taskRedeemHistory.model.dart';
import '../../../utils/assets.util.dart';

class TaskRedeemHistoryDialogComponent {
  static show({
    required List<TaskRedeemHistoryData> redeemList,
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
                      AssetsUtil.getDiamond(),
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Redeem History",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemCount: redeemList.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          height: 0.5,
                          color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                        ),
                      ),
                      itemBuilder: (context, index) => Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    redeemList[index].task??"",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: context.theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    DateHelper().dateFormatNull(date: redeemList[index].createdAt.toString(), format: "dd-MM-yyyy hh:mm:ss a"),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: context.theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetsUtil.getDiamond(),
                                height: 18,
                                width: 18,
                              ),
                              Text(
                                redeemList[index].method==1 ? "+${redeemList[index].diamonds}" : "-${redeemList[index].diamonds}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: redeemList[index].method==1 ? context.theme.colorScheme.scrim : context.theme.colorScheme.surfaceTint,
                                  height: 1,
                                  fontStyle: FontStyle.italic,
                                ),
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
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            context.theme.colorScheme.primaryFixed,
                            context.theme.colorScheme.secondaryFixed,
                          ],
                        ),
                        border: Border.all(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5),
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.surface,
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
