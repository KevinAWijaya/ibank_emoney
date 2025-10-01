import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class InterestRatePage extends StatelessWidget {
  InterestRatePage({super.key});

  final List<InterestRate> interestRates = [
    InterestRate("Individual customers", "1m", "4.50%"),
    InterestRate("Corporate customers", "2m", "5.50%"),
    InterestRate("Individual customers", "2m", "4.75%"),
    InterestRate("Corporate customers", "6m", "5.75%"),
    InterestRate("Individual customers", "5m", "5.00%"),
    InterestRate("Corporate customers", "10m", "6.00%"),
    InterestRate("Individual customers", "1m", "4.50%"),
    InterestRate("Corporate customers", "2m", "5.50%"),
    InterestRate("Individual customers", "2m", "4.75%"),
    InterestRate("Corporate customers", "6m", "5.75%"),
    InterestRate("Individual customers", "5m", "5.00%"),
    InterestRate("Corporate customers", "10m", "6.00%"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Interest rate", primaryTheme: false, showBack: true),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(marginLarge),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text("Interest kind", style: textTitle3.copyWith(color: VColor.neutral3)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Deposit",
                  style: textTitle3.copyWith(color: VColor.neutral3),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Rate",
                  style: textTitle3.copyWith(color: VColor.neutral3),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),

        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: marginSmall, horizontal: marginLarge),
          separatorBuilder: (context, index) => Divider(thickness: 1, color: VColor.grey3, height: marginMedium),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: interestRates.length,
          itemBuilder: (BuildContext context, int index) {
            final InterestRate interestRate = interestRates[index];
            return Row(
              children: [
                Expanded(flex: 3, child: Text(interestRate.name, style: textBody1)),
                Expanded(
                  flex: 1,
                  child: Text(interestRate.deposit, style: textBody1, textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    interestRate.rate,
                    style: textBody1.copyWith(color: VColor.primary1),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class InterestRate {
  final String name;
  final String deposit;
  final String rate;
  InterestRate(this.name, this.deposit, this.rate);
}
