import 'package:flutter/material.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Function() onPressed;
  final Size? minimumSize;
  final Color? backgroundColor;
  final Color? overlayColor;

  const ButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.minimumSize,
    this.backgroundColor,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          surfaceTintColor: null,
          padding: EdgeInsets.zero,
          minimumSize: minimumSize ?? const Size(45, 48),
          elevation: 0,
          backgroundColor: backgroundColor ?? ColorName.backgroundColor,
          foregroundColor: Colors.white60,
          overlayColor: overlayColor,
          shape: ContinuousRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          )),
      onPressed: onPressed,
      child: child,
    );
  }
}
