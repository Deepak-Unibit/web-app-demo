import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/helper/date.helper.dart';
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sl. No.",
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
                                "Amount",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: context.theme.colorScheme.onSurface
                                      .withOpacity(0.75),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "Status",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: context.theme.colorScheme.onSurface
                                        .withOpacity(0.75),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "Date",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: context.theme.colorScheme.onSurface
                                        .withOpacity(0.75),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemCount: withdrawRequestDataList.length,
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Divider(
                                height: 0.5,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.05),
                              ),
                            ),
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 37,
                                  child: Text(
                                    "${index+1}.",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: context.theme.colorScheme.onSurface
                                          .withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "₹ ${withdrawRequestDataList[index].amount}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context.theme.colorScheme.onSurface
                                        .withOpacity(0.75),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    withdrawRequestDataList[index].status==1 ? "Pending" : withdrawRequestDataList[index].status==2 ? "Success" : withdrawRequestDataList[index].status==3 ? "Rejected" : "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: context.theme.colorScheme.onSurface
                                          .withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    DateHelper().dateFormat(date: withdrawRequestDataList[index].createdAt??"", format: "dd MMM yy hh:mm:ss a"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: context.theme.colorScheme.onSurface
                                          .withOpacity(0.75),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
