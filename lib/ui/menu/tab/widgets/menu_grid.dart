import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class MenuGrid extends StatelessWidget {
  final List<MenuItem> items;
  final void Function(MenuItem)? onTap;
  final double minItemWidth;
  final double maxItemWidth;

  const MenuGrid({
    super.key,
    required this.items,
    this.onTap,
    this.minItemWidth = 120, // minimal lebar card
    this.maxItemWidth = 180, // maksimal lebar card
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // calculate column count
        int crossAxisCount = (constraints.maxWidth / minItemWidth).floor();

        // limit items to not exceed maxItemWidth
        double itemWidth = constraints.maxWidth / crossAxisCount;
        if (itemWidth > maxItemWidth) {
          crossAxisCount = (constraints.maxWidth / maxItemWidth).floor();
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: marginMedium,
            mainAxisSpacing: marginMedium,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: VColor.neutral6,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [VColor.dropShadowCardSmall],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onTap?.call(item),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          item.iconPath,
                          width: 28,
                          height: 28,
                          colorFilter: item.color != null ? ColorFilter.mode(item.color!, BlendMode.srcIn) : null,
                        ),
                      ),
                      spaceVerticalSuperSmall,
                      Text(
                        item.label,
                        style: caption2.copyWith(color: VColor.grey2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MenuItem {
  final String iconPath;
  final String label;
  final Color? color;
  final int id;

  MenuItem(this.id, {required this.iconPath, required this.label, this.color});
}
