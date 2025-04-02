import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/models/rank.model.dart';
import '../../../utils/assets.util.dart';

class RankDialogComponent {
  static show({required List<RankData> rankDataList, required num myRank, required String myName, required num myReferralCount}) {
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsUtil.getTrophy(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Daily Invitation Top 100",
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
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: rankDataList.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        height: 1,
                        color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                      ),
                    ),
                    itemBuilder: (context, index) => Row(
                      children: [
                        SizedBox(
                          width: 25,
                          child: index <= 2
                              ? Image.asset(
                                  index == 0
                                      ? AssetsUtil.getFirstRank()
                                      : index == 1
                                          ? AssetsUtil.getSecondRank()
                                          : AssetsUtil.getThirdRank(),
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.contain,
                                )
                              : Text(
                                  "${index + 1}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colorScheme.onSurface,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "${rankDataList[index].firstName?.trim()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: context.theme.colorScheme.onSurface.withOpacity(0.75),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${rankDataList[index].referralCount}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.person,
                          size: 18,
                          color: context.theme.colorScheme.secondaryFixed,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black12.withOpacity(0.5),
                      ],
                    ),
                    border: Border(top: BorderSide(color: context.theme.colorScheme.onSurface.withOpacity(0.25), width: 1.5)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            "$myRank",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                myName.trim(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: context.theme.colorScheme.onSurface.withOpacity(0.75),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$myReferralCount",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.person,
                            size: 18,
                            color: context.theme.colorScheme.secondaryFixed,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
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
                    ],
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
