import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class ExchangeRatePage extends StatelessWidget {
  ExchangeRatePage({super.key});

  final List<ExchangeRate> exchangeRates = [
    ExchangeRate("Argentina", "Flag AR.png", "123.456", "124.001"),
    ExchangeRate("Austria", "Flag AT.png", "456.789", "457.120"),
    ExchangeRate("China", "Flag CN.png", "234.567", "235.002"),
    ExchangeRate("England", "Flag EN.png", "678.901", "679.045"),
    ExchangeRate("France", "Flag FR.png", "345.678", "346.001"),
    ExchangeRate("India", "Flag IN.png", "567.890", "568.123"),
    ExchangeRate("Japan", "Flag JP.png", "789.012", "789.456"),
    ExchangeRate("Korea", "Flag KR.png", "901.234", "901.567"),
    ExchangeRate("Nicaragua", "Flag NI.png", "123.789", "124.012"),
    ExchangeRate("Portugal", "Flag PT.png", "234.890", "235.101"),
    ExchangeRate("Rusia", "Flag RU.png", "345.901", "346.234"),
    ExchangeRate("Ukraine", "Flag UA.png", "456.012", "456.345"),
    ExchangeRate("Vietnam", "Flag VN.png", "567.123", "567.456"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Exchange rate", primaryTheme: false, showBack: true),
      backgroundColor: VColor.neutral6,
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
                child: Text("Country", style: textTitle3.copyWith(color: VColor.neutral3)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Buy",
                  style: textTitle3.copyWith(color: VColor.neutral3),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Buy",
                  style: textTitle3.copyWith(color: VColor.neutral3),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),

        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: marginSmall, horizontal: marginLarge),
          separatorBuilder: (context, index) => Divider(thickness: 1, color: VColor.grey3, height: marginExtraLarge),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: exchangeRates.length,
          itemBuilder: (BuildContext context, int index) {
            final ExchangeRate exchangeRate = exchangeRates[index];
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Image.asset("$imagePath/${exchangeRate.icon}", width: 40, height: 30, fit: BoxFit.cover),
                      spaceHorizontalSmall,
                      Text(exchangeRate.name, style: textBody1),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(exchangeRate.buy, style: textBody1, textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 1,
                  child: Text(exchangeRate.sell, style: textBody1, textAlign: TextAlign.end),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ExchangeRate {
  final String name;
  final String icon;
  final String buy;
  final String sell;
  ExchangeRate(this.name, this.icon, this.buy, this.sell);
}
