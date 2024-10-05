import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/models/withdrawRequest.model.dart';
import '../../../utils/assets.util.dart';

class WithdrawHistoryDialogComponent {
  static show({required List<WithdrawRequestData> withdrawRequestDataList}) {
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
                      AssetsUtil.getCoin(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Withdraw Record",
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: withdrawRequestDataList.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          height: 0.5,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.05),
                        ),
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${index+1}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${withdrawRequestDataList[index].amount}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75),
                              ),
                            ),
                            Text(
                              "${withdrawRequestDataList[index].status}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75),
                              ),
                            ),
                          ],
                        ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            context.theme.colorScheme.surfaceContainerLow,
                            context.theme.colorScheme.surfaceContainerHigh,
                          ],
                        ),
                        border: Border.all(
                            color: context.theme.colorScheme.onSurface
                                .withOpacity(0.25),
                            width: 1.5),
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
