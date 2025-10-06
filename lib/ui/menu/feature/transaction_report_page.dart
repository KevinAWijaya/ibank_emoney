import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/tab/widgets/stack_card.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/chart.dart';
import 'package:intl/intl.dart';

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

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: h3 / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMax)),
              color: VColor.neutral6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                spaceVerticalLarge,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                  child: _historyList(),
                ),
                spaceVerticalLarge,
              ],
            ),
          ),
          Positioned(top: marginSmall, left: 0, right: 0, child: StackCard()),
        ],
      ),
    );
  }

  Widget _historyList() {
    final histories = TransactionReportHistory.dummyData();

    // Group by date label (Today / Yesterday / date)
    Map<String, List<TransactionReportHistory>> grouped = {};
    for (var h in histories) {
      final now = DateTime.now();
      final diff = now.difference(h.time).inDays;
      String key;
      if (diff == 0) {
        key = "Today";
      } else if (diff == 1) {
        key = "Yesterday";
      } else {
        key = DateFormat('dd MMM yyyy').format(h.time);
      }
      grouped.putIfAbsent(key, () => []).add(h);
    }

    final semanticColors = [
      VColor.primary1,
      VColor.semantic1,
      VColor.semantic2,
      VColor.semantic3,
      VColor.semantic4,
      VColor.semantic5,
    ];

    int colorIndex = 0; // persist color order across days

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        final title = entry.key;
        final list = entry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: caption1.copyWith(color: VColor.grey2)),
            spaceVerticalSmall,
            ...list.map((item) {
              final colorBox = semanticColors[colorIndex % semanticColors.length];
              colorIndex++;

              final isPositive = item.value > 0;
              final valueText = "${isPositive ? '+' : ''}${item.value.toStringAsFixed(0)}";

              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(color: colorBox, borderRadius: BorderRadius.circular(radiusSmall)),
                        child: Center(
                          child: SvgPicture.asset(
                            "$iconPath/${item.image}",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(VColor.neutral6, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      spaceHorizontalMedium,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: textBody1),
                            if (item.status.isNotEmpty)
                              Text(item.status, style: caption1.copyWith(color: VColor.neutral3)),
                          ],
                        ),
                      ),
                      Text(
                        valueText,
                        style: textTitle3.copyWith(color: isPositive ? VColor.primary1 : VColor.semantic1),
                      ),
                    ],
                  ),
                  spaceVerticalSmall,
                  Divider(color: VColor.grey3, thickness: 1, height: 0),
                  spaceVerticalSmall,
                ],
              );
            }),
            spaceVerticalMedium,
          ],
        );
      }).toList(),
    );
  }
}

class TransactionReportHistory {
  final String title;
  final String status;
  final double value;
  final String image;
  final DateTime time;

  TransactionReportHistory(this.title, this.status, this.value, this.image, this.time);

  static List<TransactionReportHistory> dummyData() {
    return [
      TransactionReportHistory("Water Bill", "Unsuccessfully", -280, "water.svg", DateTime.now()),
      TransactionReportHistory(
        "Income: Salary Oct",
        "",
        1200,
        "money_receipt.svg",
        DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransactionReportHistory(
        "Electric Bill",
        "Successfully",
        -480,
        "electric.svg",
        DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransactionReportHistory(
        "Income : Jane transfers",
        "",
        500,
        "receipt_list.svg",
        DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransactionReportHistory(
        "Internet Bill",
        "Successfully",
        -100,
        "receipt_upside.svg",
        DateTime.now().subtract(const Duration(days: 3)),
      ),
      TransactionReportHistory(
        "Netflix",
        "Unsuccessfully",
        -50,
        "receipt_list.svg",
        DateTime.now().subtract(const Duration(days: 4)),
      ),
      TransactionReportHistory(
        "Top Up Wallet",
        "",
        400,
        "receipt_upside.svg",
        DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
