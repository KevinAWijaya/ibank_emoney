import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class AppInformationPage extends StatelessWidget {
  const AppInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "App information", primaryTheme: false, showBack: true),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginLarge),
      child: Column(
        children: [
          spaceVerticalCustom(40),
          Text("CaBank E-mobile Banking", style: textTitle2),
          spaceVerticalCustom(28),
          Expanded(
            child: ListView(
              children: [
                _info("Date of manufacture", trailing: "Dec 2019"),
                _info("Version", trailing: "9.0.2"),
                _info("Language", trailing: "English"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(String title, {String? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textBody1),
          trailing != null
              ? Text(trailing, style: textTitle3.copyWith(color: VColor.primary1))
              : const Icon(Icons.chevron_right, color: VColor.neutral5),
        ],
      ),
    );
  }
}
