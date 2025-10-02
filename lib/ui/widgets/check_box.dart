import 'package:flutter/material.dart';

import '../../core/theme/color.dart';

class VCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double iconSize;
  final EdgeInsets iconPadding;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final double borderWidth;
  final Color checkColor;
  final Duration animationDuration;

  const VCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.iconSize = 16,
    this.iconPadding = const EdgeInsets.all(2),
    this.activeBorderColor = VColor.primary1,
    this.inactiveBorderColor = VColor.grey1,
    this.borderWidth = 2,
    this.checkColor = VColor.primary1,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: animationDuration,
          decoration: BoxDecoration(
            color: Colors.transparent, // keep background unchanged
            border: Border.all(color: value ? activeBorderColor : inactiveBorderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: value ? 1 : 0,
              child: Padding(
                padding: iconPadding,
                child: Icon(Icons.check, size: iconSize, color: checkColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
