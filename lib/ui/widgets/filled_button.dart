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

  const VFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.borderRadius,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? radiusLarge))),
        padding: padding ?? EdgeInsets.all(marginMedium),
        backgroundColor: VColor.primary1,
        disabledBackgroundColor: VColor.primary4,
      ),
      child: Text(text, style: textBody1.copyWith(color: VColor.neutral6)),
    );
  }
}
