import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool isFullWidth;
  final bool isActive;

  const VFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.borderRadius,
    this.isFullWidth = true,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive ? VColor.primary1 : VColor.primary4;
    final textColor = isActive ? VColor.neutral6 : VColor.neutral1;

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? radiusLarge))),
        padding: padding ?? const EdgeInsets.all(marginMedium),
        backgroundColor: backgroundColor,
      ),
      child: Text(text, style: textBody1.copyWith(color: textColor)),
    );
  }
}
