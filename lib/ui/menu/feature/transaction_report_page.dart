import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/ui/menu/tab/widgets/stack_card.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/chart.dart';

class TransactionReportPage extends StatelessWidget {
  const TransactionReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Transaction report", showBack: true),
      backgroundColor: VColor.primary1,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth.clamp(350, 450);
    double w3 = maxWidth * 0.85;
    double h3 = w3 * 3 / 5;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: h3 / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMax)),
              color: VColor.neutral6,
            ),
            child: Column(
              children: [
                spaceVerticalCustom(h3 - marginLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                  child: BalanceChart(
                    balance: 1000,
                    data: [
                      BalanceData(month: "Jan", positivePurple: 10, positivePink: 5, negativeRed: -10),
                      BalanceData(month: "Feb", positivePurple: 20, positivePink: 7, negativeRed: -20),
                      BalanceData(month: "Mar", positivePurple: 30, positivePink: 13, negativeRed: -30),
                      BalanceData(month: "Apr", positivePurple: 16, positivePink: 6, negativeRed: -16),
                      BalanceData(month: "May", positivePurple: 5, positivePink: 3, negativeRed: -5),
                      BalanceData(month: "Jun", positivePurple: 24, positivePink: 10, negativeRed: -24),
                      BalanceData(month: "Jul", positivePurple: 6, positivePink: 3, negativeRed: -6),
                      BalanceData(month: "Aug", positivePurple: 16, positivePink: 10, negativeRed: -16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(top: marginSmall, left: 0, right: 0, child: StackCard()),
      ],
    );
  }
}
