import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VAppBar({super.key, required this.title, this.textColor = VColor.onPrimary});

  final String title;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: VColor.primary1,
      title: Text(title, style: textTitle2.copyWith(color: textColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
