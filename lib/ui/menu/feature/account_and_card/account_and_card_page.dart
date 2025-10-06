import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/account_and_card/detail_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';

class AccountAndCardPage extends StatefulWidget {
  const AccountAndCardPage({super.key});

  @override
  State<AccountAndCardPage> createState() => _AccountAndCardPageState();
}

class _AccountAndCardPageState extends State<AccountAndCardPage> {
  int selectedTab = 0; // 0 = Account, 1 = Card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Account and card", primaryTheme: false, showBack: true),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceVerticalLarge,
          Row(
            children: [
              Expanded(
                child: VFilledButton(
                  text: "Account",
                  isActive: selectedTab == 0,
                  onPressed: () {
                    setState(() => selectedTab = 0);
                  },
                ),
              ),
              spaceHorizontalMedium,
              Expanded(
                child: VFilledButton(
                  text: "Card",
                  isActive: selectedTab == 1,
                  onPressed: () {
                    setState(() => selectedTab = 1);
                  },
                ),
              ),
            ],
          ),
          Expanded(child: selectedTab == 0 ? _accountPlaceholder() : _cardPlaceholder(context)),
        ],
      ),
    );
  }

  Widget _accountPlaceholder() {
    final cards = AccountCardModel.dummyData();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: marginExtraLarge),
      key: const ValueKey("account"),
      child: Column(
        children: [
          // Avatar
          Center(child: CircleAvatar(radius: 50, backgroundImage: AssetImage("$imagePath/Avatar Male.png"))),
          spaceVerticalSmall,
          // Name
          Text("Push Puttichai", style: textTitle3.copyWith(color: VColor.primary1)),
          spaceVerticalSuperLarge,
          // Card list
          Column(
            children: cards.map((card) {
              return Container(
                margin: const EdgeInsets.only(bottom: marginMedium),
                padding: const EdgeInsets.all(marginMedium),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMedium),
                  boxShadow: [VColor.dropShadowCardSmall],
                ),
                child: Column(
                  children: [
                    // Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(card.accountName, style: textTitle3),
                        Text(card.accountNumber, style: textTitle3),
                      ],
                    ),
                    spaceVerticalSmall,
                    // Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Available balance", style: caption2.copyWith(color: VColor.grey2)),
                        Text("\$${card.balance.toStringAsFixed(2)}", style: caption1.copyWith(color: VColor.primary1)),
                      ],
                    ),
                    spaceVerticalSuperSmall,
                    // Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Branch", style: caption2.copyWith(color: VColor.grey2)),
                        Text(card.branch, style: caption1.copyWith(color: VColor.primary1)),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          spaceVerticalLarge,
        ],
      ),
    );
  }

  Widget _cardPlaceholder(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth.clamp(350, 450);
    double w3 = maxWidth * 0.9;
    double h3 = w3 * 3 / 5;

    final cards = [
      CardItem(
        holderName: "John Smith",
        cardType: "Amazon Platinium",
        cardNumber: "1234 **** **** 5678",
        balance: "\$3,469.52",
        image: "$imagePath/Card Blue.png",
        validFrom: "10/15",
        validUntil: "10/20",
      ),
      CardItem(
        holderName: "Jane Doe",
        cardType: "Visa Gold",
        cardNumber: "9876 **** **** 4321",
        balance: "\$1,254.00",
        image: "$imagePath/Card Yellow.png",
        validFrom: "01/22",
        validUntil: "01/27",
      ),
    ];

    return SingleChildScrollView(
      key: const ValueKey("card"),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          spaceVerticalLarge,
          // === List Card ===
          ...cards.map((card) => _buildCardItem(card, w3, h3)),
          spaceVerticalSuperLarge,

          // === Add Card Button ===
          SizedBox(
            width: double.infinity,
            child: VFilledButton(text: "Add card", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(CardItem card, double width, double height) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountAndCardDetailPage(cardItem: card)));
        },
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(bottom: marginLarge),
          padding: EdgeInsets.symmetric(horizontal: marginMedium, vertical: marginMedium),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusLarge),
            image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
            boxShadow: [VColor.dropShadowCard],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(card.holderName, style: textBody2.copyWith(fontSize: 24, color: VColor.neutral6)),
              const Spacer(),
              Text(card.cardType, style: textBody3.copyWith(color: VColor.neutral6)),
              spaceVerticalSmall,
              Text(card.cardNumber, style: textBody3.copyWith(color: VColor.neutral6)),
              spaceVerticalSmall,
              Text(card.balance, style: textTitle2.copyWith(color: VColor.neutral6)),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountCardModel {
  final String accountName;
  final String accountNumber;
  final double balance;
  final String branch;

  AccountCardModel({
    required this.accountName,
    required this.accountNumber,
    required this.balance,
    required this.branch,
  });

  static List<AccountCardModel> dummyData() {
    return [
      AccountCardModel(accountName: "Account 1", accountNumber: "1234 5678 8978", balance: 2450.75, branch: "New York"),
      AccountCardModel(
        accountName: "Account 2",
        accountNumber: "9876 5432 1098",
        balance: 1340.20,
        branch: "Los Angeles",
      ),
      AccountCardModel(accountName: "Account 3", accountNumber: "5678 9012 3456", balance: 5890.00, branch: "Chicago"),
    ];
  }
}

class CardItem {
  final String holderName;
  final String cardType;
  final String cardNumber;
  final String balance;
  final String image;
  final String validFrom;
  final String validUntil;

  CardItem({
    required this.holderName,
    required this.cardType,
    required this.cardNumber,
    required this.balance,
    required this.image,
    required this.validFrom,
    required this.validUntil,
  });
}
