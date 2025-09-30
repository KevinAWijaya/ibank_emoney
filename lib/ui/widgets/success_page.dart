import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
    this.titleAppbar = "",
    required this.image,
    required this.description,
    required this.title,
    this.onPressed,
  });

  final String titleAppbar;
  final String image;
  final String title;
  final String description;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: titleAppbar, primaryTheme: false),
      backgroundColor: VColor.neutral6,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(marginLarge),
          child: Column(
            children: [
              Image.asset('$imagePath/$image', height: 300, fit: BoxFit.contain),
              spaceVerticalSuperLarge,
              Text(
                title,
                style: textTitle3.copyWith(color: VColor.primary1),
                textAlign: TextAlign.center,
              ),
              spaceVerticalLarge,
              Text(description, style: textBody3, textAlign: TextAlign.center),
              spaceVerticalSuperLarge,
              SizedBox(
                width: double.infinity,
                child: VFilledButton(text: "Ok", onPressed: onPressed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
