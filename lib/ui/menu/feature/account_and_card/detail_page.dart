import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/account_and_card/account_and_card_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class AccountAndCardDetailPage extends StatelessWidget {
  const AccountAndCardDetailPage({super.key, required this.cardItem});
  final CardItem cardItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Card", primaryTheme: false, showBack: true),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(marginLarge),
      child: Column(
        children: [
          _detailField("Name", cardItem.holderName),
          spaceVerticalMedium,
          _detailField("Card number", cardItem.cardNumber),
          spaceVerticalMedium,
          _detailField("Valid from", cardItem.validFrom),
          spaceVerticalMedium,
          _detailField("Good thru", cardItem.validUntil),
          spaceVerticalMedium,
          _detailField("Available balance", cardItem.balance),
          spaceVerticalMedium,
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text("Delete card", style: textBody1.copyWith(color: VColor.semantic1)),
              onPressed: () {},
            ),
          ),
          spaceVerticalSuperLarge,
        ],
      ),
    );
  }

  Widget _detailField(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textBody1.copyWith(color: VColor.neutral2)),
        spaceHorizontalSuperSmall,
        Text(value, style: textTitle3.copyWith(color: VColor.primary1)),
      ],
    );
  }
}
