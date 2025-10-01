import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final int selectedCountry = 4;

  final List<Language> exchangeRates = [
    Language("Argentina", "Flag AR.png"),
    Language("Austria", "Flag AT.png"),
    Language("China", "Flag CN.png"),
    Language("England", "Flag EN.png"),
    Language("France", "Flag FR.png"),
    Language("India", "Flag IN.png"),
    Language("Japan", "Flag JP.png"),
    Language("Korea", "Flag KR.png"),
    Language("Nicaragua", "Flag NI.png"),
    Language("Portugal", "Flag PT.png"),
    Language("Rusia", "Flag RU.png"),
    Language("Ukraine", "Flag UA.png"),
    Language("Vietnam", "Flag VN.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Language", primaryTheme: false, showBack: true),
      backgroundColor: VColor.neutral6,
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: marginSmall, horizontal: marginLarge),
      separatorBuilder: (context, index) => Divider(thickness: 1, color: VColor.grey3, height: marginExtraLarge),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: exchangeRates.length,
      itemBuilder: (BuildContext context, int index) {
        final Language exchangeRate = exchangeRates[index];
        return Row(
          children: [
            Image.asset("$imagePath/${exchangeRate.icon}", width: 40, height: 30, fit: BoxFit.cover),
            spaceHorizontalSmall,
            Expanded(
              child: Text(
                exchangeRate.name,
                style: textBody1.copyWith(color: selectedCountry == index ? VColor.neutral1 : VColor.neutral3),
              ),
            ),
            if (selectedCountry == index) ...[
              spaceHorizontalSmall,
              Icon(Icons.check, size: iconSmall, color: VColor.primary1),
            ],
          ],
        );
      },
    );
  }
}

class Language {
  final String name;
  final String icon;
  Language(this.name, this.icon);
}
