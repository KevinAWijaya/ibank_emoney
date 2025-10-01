import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/theme/color.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const NotificationIcon({super.key, this.count = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            '$iconPath/notification.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(VColor.neutral6, BlendMode.srcIn),
          ),

          // Badge (only show if count > 0)
          if (count > 0)
            Positioned(
              right: -5,
              top: -10,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: VColor.semantic1, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Center(
                  child: Text(
                    count > 99 ? "99+" : "$count",
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
