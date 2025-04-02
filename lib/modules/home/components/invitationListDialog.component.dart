import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/models/invitation.model.dart';

import '../../../utils/assets.util.dart';

class InvitationListDialogComponent {
  static show({required List<InvitationData> invitationDataList, required Function onRemind,}) {
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
                      AssetsUtil.getInvite(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Invitation History",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "You Have Invited",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onSurface,
                      fontStyle: FontStyle.italic,
                    ),
                    children: [
                      TextSpan(
                        text: " ${invitationDataList.length}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.primaryFixed,
                        ),
                      ),
                      const TextSpan(
                        text: " Friends:",
                      )
                    ],
                  ),
                ),
                Text(
                  "If the person you invite doesn't join our channel, you can't get scratch card!",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: context.theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: context.theme.colorScheme.onSurface.withOpacity(0.25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "User Name",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: context.theme.colorScheme.onSurface.withOpacity(0.75),
                                ),
                              ),
                              Text(
                                "Join Channel",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: context.theme.colorScheme.onSurface.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemCount: invitationDataList.length,
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Divider(
                                height: 0.5,
                                color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                              ),
                            ),
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${invitationDataList[index].firstName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: context.theme.colorScheme.onSurface.withOpacity(0.75),
                                  ),
                                ),
                                SizedBox(
                                  width: 106,
                                  child: Row(
                                    children: [
                                      Text(
                                        (invitationDataList[index].joinedChannels ?? false) ? "Yes" : "No",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: (invitationDataList[index].joinedChannels ?? false) ? context.theme.colorScheme.scrim : context.theme.colorScheme.surfaceTint,
                                        ),
                                      ),
                                      !(invitationDataList[index].joinedChannels ?? false) ? const SizedBox(width: 5) : const SizedBox.shrink(),
                                      !(invitationDataList[index].joinedChannels ?? false)
                                          ? MaterialButton(
                                              onPressed: () => onRemind(),
                                              minWidth: 0,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                              visualDensity: VisualDensity.compact,
                                              highlightColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              color: context.theme.colorScheme.primaryFixed,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                              child: Text(
                                                "Remind",
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: context.theme.colorScheme.surface),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
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
