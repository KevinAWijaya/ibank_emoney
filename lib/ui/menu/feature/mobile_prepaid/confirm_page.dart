import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/navigation_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/success_page.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

class ConfirmationMobilePrepaidPage extends StatefulWidget {
  const ConfirmationMobilePrepaidPage({super.key});

  @override
  State<ConfirmationMobilePrepaidPage> createState() => _ConfirmationMobilePrepaidPageState();
}

class _ConfirmationMobilePrepaidPageState extends State<ConfirmationMobilePrepaidPage> {
  final _formKey = GlobalKey<FormState>();

  VerificationType verificationType = VerificationType.otp;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  bool get _isFilled => otpController.text.isNotEmpty;

  bool isTouched = false;

  @override
  void initState() {
    super.initState();
    otpController.addListener(_onChanged);

    fromController.text = "**** **** 6789";
    toController.text = "Amanda";
    amountController.text = "\$1000";
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Confirm", showBack: true, primaryTheme: false),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(marginLarge),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Confirm transaction information", style: caption1.copyWith(color: VColor.neutral3)),
            spaceVerticalSmall,
            VTextField(controller: fromController, label: "From", readOnly: true),
            spaceVerticalLarge,
            VTextField(controller: toController, label: "To", readOnly: true),
            spaceVerticalLarge,
            VTextField(controller: amountController, label: "Amount", readOnly: true),
            spaceVerticalLarge,
            _verificationType(),
            spaceVerticalCustom(40),
            SizedBox(
              width: double.infinity,
              child: VFilledButton(
                text: "Confirm",
                onPressed: _isFilled || isTouched
                    ? () {
                        if (verificationType == VerificationType.otp) {
                          if (_formKey.currentState!.validate()) {
                            verificationType = VerificationType.fingerprint;
                            otpController.text = "";
                            isTouched = false;
                            _onChanged();
                          }
                        } else if (verificationType == VerificationType.fingerprint) {
                          verificationType = VerificationType.faceRecognition;
                          otpController.text = "";
                          isTouched = false;
                          _onChanged();
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessPage(
                                image: "Illustration 2.png",
                                description: "You have successfully paid mobile prepaid!",
                                title: "Payment success!",
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => NavigationPage()),
                                  );
                                },
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verificationType() {
    switch (verificationType) {
      case VerificationType.otp:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: VTextField(controller: otpController, label: "Get OTP to verify transaction", hint: "OTP"),
            ),
            spaceHorizontalSmall,
            VFilledButton(text: "Get OTP", onPressed: () {}),
          ],
        );
      case VerificationType.fingerprint:
        return Align(
          alignment: Alignment.center,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                isTouched = true;
                _onChanged();
              },
              child: SvgPicture.asset("$iconPath/finger.svg", width: 64, height: 64),
            ),
          ),
        );
      case VerificationType.faceRecognition:
        return Align(
          alignment: Alignment.center,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                isTouched = true;
                _onChanged();
              },
              child: SvgPicture.asset("$iconPath/face_id.svg", width: 64, height: 64),
            ),
          ),
        );
    }
  }
}

enum VerificationType { otp, fingerprint, faceRecognition }
