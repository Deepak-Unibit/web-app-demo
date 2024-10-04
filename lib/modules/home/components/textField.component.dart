import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isBorder = false,
    required this.textInputType,
    required this.maxLength,
    this.maxLines = 1,
    this.height = 50,
   this.textInputAction,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final bool isBorder;
  final TextInputType textInputType;
  final int maxLength;
  final int maxLines;
  final double height;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: textEditingController,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: textInputType,
        textInputAction: textInputAction ?? null,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.theme.colorScheme.onSurface.withOpacity(0.05),
          counterText: "",
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: context.theme.colorScheme.onSurface.withOpacity(0.15),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: context.theme.colorScheme.onSurface.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
