import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/forgot_password/forgot_code_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

import '../../../core/theme/color.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  bool get _isFilled => phoneController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _form(),
      backgroundColor: VColor.background,
      appBar: VAppBar(title: "Forgot Password", primaryTheme: false, showBack: true),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VTextField(
              hint: "(+62)",
              controller: phoneController,
              keyboardType: TextInputType.phone,
              preffixText: "(+62)",
              label: "Type your phone number",
              validator: (value) => (value == null || value.length < 9) ? "Enter valid phone" : null,
            ),
            spaceVerticalLarge,
            Text("We texted you a code to verify your phone number", style: textBody3.copyWith(color: VColor.neutral2)),
            spaceVerticalLarge,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotCodePage()));
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusLarge))),
                  padding: EdgeInsets.all(marginMedium),
                  backgroundColor: VColor.primary1,
                  disabledBackgroundColor: VColor.primary4,
                ),
                child: Text("Send", style: textBody1.copyWith(color: VColor.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
