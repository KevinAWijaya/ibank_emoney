import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VAppBar({super.key, required this.title, this.showBack = false, this.primaryTheme = true, this.onBackPressed});

  final String title;
  final bool showBack;
  final bool primaryTheme;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryTheme ? VColor.primary1 : VColor.background,
      title: Text(title, style: textTitle2.copyWith(color: primaryTheme ? VColor.neutral6 : VColor.neutral1)),
      titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              color: primaryTheme ? VColor.neutral6 : VColor.neutral1,
              onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
            )
          : const SizedBox.shrink(),
      leadingWidth: showBack ? null : 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
