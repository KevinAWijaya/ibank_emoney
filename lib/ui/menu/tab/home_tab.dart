import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/tranfer/tranfer_page.dart';
import 'package:ibank_emoney/ui/menu/feature/transaction_report_page.dart';
import 'package:ibank_emoney/ui/menu/tab/widgets/menu_grid.dart';
import 'package:ibank_emoney/ui/menu/tab/widgets/stack_card.dart';
import 'package:ibank_emoney/ui/widgets/notification_icon.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VColor.primary1,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _body()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(width: double.infinity, color: VColor.neutral6),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Container(height: MediaQuery.of(context).padding.top, color: VColor.primary1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginMedium),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("$imagePath/Avatar Male.png"),
                backgroundColor: Colors.transparent,
              ),
              spaceHorizontalMedium,
              Expanded(
                child: Text("Hi, Push Puttican!", style: textBody1.copyWith(color: VColor.neutral6)),
              ),
              spaceHorizontalMedium,
              NotificationIcon(
                count: 5,
                onTap: () {
                  debugPrint("Go to notifications");
                },
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLarge)),
            color: VColor.neutral6,
          ),
          padding: EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginMedium),
          child: Column(
            children: [
              StackCard(),
              spaceVerticalSuperLarge,
              MenuGrid(
                items: [
                  MenuItem(0, iconPath: "$iconPath/wallet.svg", label: "Account and Card"),
                  MenuItem(1, iconPath: "$iconPath/sync_devices.svg", label: "Tranfer"),
                  MenuItem(2, iconPath: "$iconPath/credit_card_in.svg", label: "Withdraw"),
                  MenuItem(3, iconPath: "$iconPath/mobile_banking.svg", label: "Mobile prepaid"),
                  MenuItem(4, iconPath: "$iconPath/receipt_list.svg", label: "Pay the bill"),
                  MenuItem(5, iconPath: "$iconPath/pig.svg", label: "Save Online"),
                  MenuItem(6, iconPath: "$iconPath/credit_card.svg", label: "Credit card"),
                  MenuItem(7, iconPath: "$iconPath/file_paragraph.svg", label: "Transaction report"),
                  MenuItem(8, iconPath: "$iconPath/contact.svg", label: "Beneficiary"),
                ],
                onTap: onMenuTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onMenuTap(MenuItem item) {
    switch (item.id) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Placeholder()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => TranferPage()));
        break;
      case 7:
        Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionReportPage()));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Placeholder()));
        break;
    }
  }
}
