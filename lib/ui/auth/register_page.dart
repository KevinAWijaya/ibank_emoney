import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/login_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

import '../widgets/check_box.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool get _isFilled =>
      nameController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      isChecked;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onChanged);
    phoneController.addListener(_onChanged);
    passwordController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _body(context)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(width: double.infinity, color: VColor.white),
          ),
        ],
      ),
      backgroundColor: VColor.primary1,
      appBar: VAppBar(title: "Sign Up"),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VColor.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMax)),
      ),
      padding: EdgeInsets.all(marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to us,",
            style: textTitle1.copyWith(color: VColor.primary1),
            textAlign: TextAlign.start,
          ),
          spaceVerticalSuperSmall,
          Text("Hello there, create New account", style: caption2.copyWith(color: VColor.neutral1)),
          spaceVerticalSuperLarge,
          Align(
            alignment: Alignment.center,
            child: Image.asset('$imagePath/Circle Phone.png', height: 165, fit: BoxFit.contain),
          ),
          spaceVerticalSuperLarge,
          _form(),
          spaceVerticalSuperLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have an account?", style: GoogleFonts.poppins(fontSize: 12)),
              spaceHorizontalSmall,
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Sign In", style: caption1.copyWith(color: VColor.primary1)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          VTextField(
            hint: "Name",
            controller: nameController,
            validator: (value) => (value == null || value.isEmpty) ? "Name is required" : null,
          ),
          spaceVerticalMedium,
          VTextField(
            hint: "Phone Number",
            controller: phoneController,
            keyboardType: TextInputType.phone,
            preffixText: "(+62)",
            validator: (value) => (value == null || value.length < 9) ? "Enter valid phone" : null,
          ),
          spaceVerticalMedium,
          VTextField(
            hint: "Password",
            controller: passwordController,
            isObscure: true,
            validator: (value) => (value == null || value.length < 6) ? "Min 6 characters" : null,
          ),
          spaceVerticalMedium,
          Row(
            children: [
              CustomCheckbox(
                value: isChecked,
                onChanged: (v) => setState(() => isChecked = v),
                iconSize: 20,
                activeBorderColor: VColor.primary1,
                inactiveBorderColor: VColor.grey1,
                borderWidth: 2,
                checkColor: VColor.primary1,
              ),
              spaceHorizontalSmall,
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: textBody2.copyWith(color: VColor.neutral1),
                    children: [
                      const TextSpan(text: "By creating an account you agree to our "),
                      TextSpan(
                        text: "Term and Conditions",
                        style: textTitle3.copyWith(color: VColor.primary1),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("Terms & Conditions clicked!");
                          },
                      ),
                    ],
                  ),
                ),
              ),
              spaceHorizontalLarge,
            ],
          ),
          spaceVerticalCustom(40),
          SizedBox(
            width: double.infinity,
            child: VFilledButton(
              text: "Sign up",
              onPressed: _isFilled
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        // Submit
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
