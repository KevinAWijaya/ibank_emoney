import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/login_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/success_page.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

import '../../../core/theme/color.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, this.fromProfile = false});
  final bool fromProfile;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final currentController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  bool get _isFilled => password1Controller.text.isNotEmpty && password2Controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    password1Controller.addListener(_onChanged);
    password2Controller.addListener(_onChanged);
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
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.fromProfile) ...[
              VTextField(
                controller: currentController,
                label: "Current Password",
                hint: "Current Password",
                isObscure: true,
                validator: (value) => (value == null || value.length < 6) ? "Min 6 characters" : null,
              ),
              spaceVerticalMedium,
            ],
            VTextField(
              controller: password1Controller,
              label: "Type your new password",
              hint: "Type your new password",
              isObscure: true,
              validator: (value) => (value == null || value.length < 6) ? "Min 6 characters" : null,
            ),
            spaceVerticalMedium,
            VTextField(
              controller: password2Controller,
              label: "Confirm password",
              hint: "Confirm password",
              isObscure: true,
              validator: (value) => (value == null || password1Controller.text != password2Controller.text)
                  ? "Your password is not match"
                  : null,
            ),
            spaceVerticalCustom(64),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isFilled
                    ? () {
                        if (widget.fromProfile) {
                          Navigator.pop(context);
                        } else {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessPage(
                                  image: "Illustration 1.png",
                                  description:
                                      "You have successfully change password. Please use the new password when Sign in.",
                                  title: "Change password successfully!",
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                    );
                                  },
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusLarge))),
                  padding: EdgeInsets.all(marginMedium),
                  backgroundColor: VColor.primary1,
                  disabledBackgroundColor: VColor.primary4,
                ),
                child: Text("Change password", style: textBody1.copyWith(color: VColor.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
