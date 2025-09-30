import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/forgot_password/change_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

import '../../../core/theme/color.dart';

class ForgotCodePage extends StatefulWidget {
  const ForgotCodePage({super.key});

  @override
  State<ForgotCodePage> createState() => _ForgotCodePageState();
}

class _ForgotCodePageState extends State<ForgotCodePage> {
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();

  bool get _isFilled => codeController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    codeController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: VColor.background,
      appBar: VAppBar(title: "Forgot Password", primaryTheme: false, showBack: true),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _form(),
        Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            margin: EdgeInsets.all(marginMedium),
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Text("Change your phone number", style: caption1.copyWith(color: VColor.primary1)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _form() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(marginLarge),
      padding: EdgeInsets.all(marginMedium),
      decoration: BoxDecoration(
        color: VColor.background,
        boxShadow: [VColor.dropShadowCard],
        borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: VTextField(
                    hint: "code",
                    controller: codeController,
                    keyboardType: TextInputType.phone,
                    label: "Type a code",
                    validator: (value) => (value == null) ? "Enter code" : null,
                  ),
                ),
                spaceHorizontalSmall,
                VFilledButton(
                  text: "Resend",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
            spaceVerticalLarge,
            RichText(
              text: TextSpan(
                style: textBody3.copyWith(color: VColor.neutral2),
                children: [
                  const TextSpan(text: "We texted you a code to verify your phone number "),
                  TextSpan(
                    text: "(+62) 0398829xxx",
                    style: textTitle3.copyWith(color: VColor.primary1),
                  ),
                ],
              ),
            ),
            spaceVerticalSmall,
            Text(
              "This code will expired 10 minutes after this message. If you don't get a message.",
              style: textBody3.copyWith(color: VColor.neutral2),
            ),
            spaceVerticalLarge,
            SizedBox(
              width: double.infinity,
              child: VFilledButton(
                text: "Send",
                onPressed: _isFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
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
}
