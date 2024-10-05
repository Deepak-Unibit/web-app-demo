import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';
import '../../../models/myProfile.model.dart';
import '../../../models/withdrawDetails.model.dart';
import '../../../utils/assets.util.dart';

class CashOutDialogComponent {
  static show(
      {required Function onEdit, required Function onWithdrawRecord, required Function onWithdraw, required MyProfileData myProfileData, required WithdrawDetailsData withdrawDetailsData}) {
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
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsUtil.getCoin(),
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Cash Out",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "To Be Cashed Out:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${((myProfileData.earnedAmount??0) * 100).truncateToDouble() / 100}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        height: 0.5,
                        color: context.theme.colorScheme.onSurface
                            .withOpacity(0.1),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Success Withdrawal:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${((withdrawDetailsData.successWithDrawl??0) * 100).truncateToDouble() / 100}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        height: 0.5,
                        color: context.theme.colorScheme.onSurface
                            .withOpacity(0.1),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Under Review:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${((withdrawDetailsData.underReview ?? 0) * 100).truncateToDouble() / 100}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: ()=>onWithdrawRecord(),
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Withdrawal Record",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurface
                                .withOpacity(0.75),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined, size: 24, color: context.theme.colorScheme.onSurface
                            .withOpacity(0.75),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AssetsUtil.getCardIcon(),
                            height: 24,
                            width: 35,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Account Info",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.onSurface
                                  .withOpacity(0.75),
                            ),
                          ),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () => onEdit(),
                            minWidth: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            visualDensity: VisualDensity.compact,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverElevation: 0,
                            focusElevation: 0,
                            color: Colors.black12.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.15),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 16,
                                  color: context.theme.colorScheme.onSurface,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: context.theme.colorScheme.onSurface,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Divider(
                        height: 0.5,
                        color: context.theme.colorScheme.onSurface
                            .withOpacity(0.1),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Name: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75)),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            myProfileData.accountHolderName ?? "--",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "UPI ID: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75)),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            myProfileData.upiId ?? "--",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Mobile Number: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.75)),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            myProfileData.phoneNumber ?? "--",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: MaterialButton(
                        onPressed: () => Get.back(),
                        minWidth: 0,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            color: context.theme.colorScheme.onSurface.withOpacity(0.1),
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
                    const SizedBox(width: 15),
                    Flexible(
                      child: SecondaryButtonComponent(
                        onClick: () => onWithdraw(),
                        height: 35,
                        width: double.infinity,
                        text: "Cash Out",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
