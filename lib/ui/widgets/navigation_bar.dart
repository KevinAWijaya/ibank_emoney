import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  const VNavigationBar({super.key, required this.selectedIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: marginLarge, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;

          return InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: marginSmall, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? VColor.primary1 : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusMax),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    isSelected ? item.iconPathActive : item.iconPath,
                    width: iconSmall,
                    height: iconSmall,
                    colorFilter: ColorFilter.mode(isSelected ? VColor.neutral6 : VColor.neutral2, BlendMode.srcIn),
                  ),
                  if (isSelected) ...[
                    spaceHorizontalSuperSmall,
                    Text(item.label, style: textBody2.copyWith(fontSize: 12, color: VColor.neutral6)),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavItem {
  final String label;
  final String iconPath;
  final String iconPathActive;
  final Widget child;
  const NavItem(this.child, this.label, this.iconPath, this.iconPathActive);
}
