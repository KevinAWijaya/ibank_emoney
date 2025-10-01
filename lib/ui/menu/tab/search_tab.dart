import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class SearchTab extends StatefulWidget {
  final VoidCallback? onBack;

  const SearchTab({super.key, this.onBack});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Search", primaryTheme: false, onBackPressed: widget.onBack, showBack: true),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(marginLarge),
      child: Column(
        children: [
          _card("Branch", "Search for branch", "Illustration Branch.png", onTap: () {}),
          _card("Interest rate", "Search for interest rate", "Illustration Interest.png", onTap: () {}),
          _card("Exchange rate", "Search for exchange rate", "Illustration Exchange rate.png", onTap: () {}),
          _card("Exchange", "Exchange amount of money", "Illustration Exchange.png", onTap: () {}),
        ],
      ),
    );
  }

  Widget _card(String title, String desc, String image, {void Function()? onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
            color: VColor.neutral6,
            boxShadow: [VColor.dropShadowCard],
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTitle3),
                    spaceVerticalSuperSmall,
                    Text(desc, style: caption2.copyWith(color: VColor.grey2)),
                  ],
                ),
              ),
              spaceHorizontalMedium,
              Image.asset('$imagePath/$image', height: 80, fit: BoxFit.fitHeight),
            ],
          ),
        ),
      ),
    );
  }
}
