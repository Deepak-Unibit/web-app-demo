import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/modules/home/components/secondaryButton.component.dart';
import 'package:web_app_demo/modules/home/components/textField.component.dart';

import '../../../utils/assets.util.dart';

class AccountInfoDialogComponent {
  static show({required TextEditingController nameController, required TextEditingController upiController, required TextEditingController mobileNumberController, required Function onBack, required Function onSave,}) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsUtil.getCardIcon(),
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Set Account Info",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Necessary for withdrawal.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: context.theme.colorScheme.onSurface.withOpacity(0.75)
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onSurface.withOpacity(0.75)
                  ),
                ),
                const SizedBox(height: 5),
                TextFieldComponent(textEditingController: nameController, hintText: "Enter the name on you bank account", textInputType: TextInputType.name, maxLength: 100, height: 35,),
                const SizedBox(height: 10),
                Text(
                  "UPI ID",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onSurface.withOpacity(0.75)
                  ),
                ),
                const SizedBox(height: 5),
                TextFieldComponent(textEditingController: upiController, hintText: "Enter Your UPI ID", textInputType: TextInputType.name, maxLength: 100, height: 35,),
                const SizedBox(height: 10),
                Text(
                  "Mobile Number",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onSurface.withOpacity(0.75)
                  ),
                ),
                const SizedBox(height: 5),
                TextFieldComponent(textEditingController: mobileNumberController, hintText: "Enter Your Mobile Number", textInputType: TextInputType.number, maxLength: 10, height: 35,),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: MaterialButton(
                        onPressed: () => onBack(),
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
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            color: context.theme.colorScheme.onSurface.withOpacity(0.05),
                            border: Border.all(
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(0.25),
                                width: 1.5),
                          ),
                          child: Text(
                            "Back",
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
                        onClick: () => onSave(),
                        height: 35,
                        width: double.infinity,
                        text: "Save",
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