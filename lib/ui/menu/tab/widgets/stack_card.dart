import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class StackCard extends StatelessWidget {
  const StackCard({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    // ✅ Lebar antara 400 - 450
    double maxWidth = screenWidth.clamp(350, 450);

    double w1 = maxWidth * 0.75;
    double w2 = maxWidth * 0.80;
    double w3 = maxWidth * 0.85;

    double h1 = w1 * 3 / 5;
    double h2 = w2 * 3 / 5;
    double h3 = w3 * 3 / 5;

    return Center(
      child: SizedBox(
        height: h3 + 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layer 1
            Positioned(
              bottom: 0,
              child: Container(
                width: w1,
                height: h1,
                decoration: BoxDecoration(color: VColor.primary2, borderRadius: BorderRadius.circular(16)),
              ),
            ),

            // Layer 2
            Positioned(
              bottom: 15,
              child: Container(
                width: w2,
                height: h2,
                decoration: BoxDecoration(color: VColor.semantic1, borderRadius: BorderRadius.circular(16)),
              ),
            ),

            // Layer 3
            Positioned(
              bottom: 30,
              child: Container(
                width: w3,
                height: h3,
                padding: EdgeInsets.symmetric(horizontal: marginMedium, vertical: marginMedium),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage("$imagePath/Card Blue.png"), fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("John Smith", style: textBody2.copyWith(fontSize: 24, color: VColor.neutral6)),
                    Spacer(),
                    Text("Amazon Platinium", style: textBody3.copyWith(color: VColor.neutral6)),
                    spaceVerticalSmall,
                    Text("1234 **** **** 5678", style: textBody3.copyWith(color: VColor.neutral6)),
                    spaceVerticalSmall,
                    Text("\$3.469.52", style: textTitle2.copyWith(color: VColor.neutral6)),
                    spaceVerticalSmall,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
