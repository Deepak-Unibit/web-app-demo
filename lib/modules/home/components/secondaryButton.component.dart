import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryButtonComponent extends StatelessWidget {
  const SecondaryButtonComponent({
    super.key, required this.onClick, required this.height, required this.width, required this.text,
  });

  final String text;
  final Function onClick;
  final double height;
  final double width;

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
          borderRadius:
          const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.theme.colorScheme.primaryFixed,
              context.theme.colorScheme.secondaryFixed,
            ],
          ),
          border: Border.all(
              color: context.theme.colorScheme.onSurface
                  .withOpacity(0.25),
              width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.surface,
            height: 1,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}