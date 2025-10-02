import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/navigation_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';

class SuccessTranferPage extends StatelessWidget {
  const SuccessTranferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Confirm", primaryTheme: false),
      backgroundColor: VColor.neutral6,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(marginLarge),
          child: Column(
            children: [
              Image.asset('$imagePath/Illustration 4.png', height: 300, fit: BoxFit.contain),
              spaceVerticalSuperLarge,
              Text(
                "Transfer successful!",
                style: textTitle3.copyWith(color: VColor.primary1),
                textAlign: TextAlign.center,
              ),
              spaceVerticalLarge,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textBody3.copyWith(color: VColor.neutral1), // default style
                    children: [
                      const TextSpan(text: "You have successfully transferred "),
                      TextSpan(
                        text: "\$ 1,000",
                        style: textBody3.copyWith(color: VColor.semantic1), // amount highlighted
                      ),
                      const TextSpan(text: " to "),
                      TextSpan(
                        text: "Amanda!",
                        style: textBody3.copyWith(color: VColor.primary1), // name highlighted
                      ),
                    ],
                  ),
                ),
              ),
              spaceVerticalSuperLarge,
              SizedBox(
                width: double.infinity,
                child: VFilledButton(
                  text: "Confirm",
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
