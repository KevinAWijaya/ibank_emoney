import 'package:flutter/material.dart';

import '../../core/constants/size.dart';
import '../../core/theme/color.dart';
import '../../core/theme/style.dart';

class VClickableField extends StatelessWidget {
  const VClickableField({super.key, required this.text, this.hint, this.label, this.onTap, this.suffixIcon});

  final String? text;
  final String? hint;
  final String? label;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(label!, style: caption1.copyWith(color: VColor.grey2)),
          ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMedium),
                border: Border.all(color: VColor.neutral4, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text?.isNotEmpty == true ? text! : (hint ?? ""),
                      style: text?.isNotEmpty == true
                          ? textBody3.copyWith(color: VColor.neutral1)
                          : textBody3.copyWith(color: VColor.neutral4),
                    ),
                  ),
                  if (suffixIcon != null) suffixIcon!,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
