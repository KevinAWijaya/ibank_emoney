import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/forgot_password/forgot_input_page.dart';
import 'package:ibank_emoney/ui/auth/register_page.dart';
import 'package:ibank_emoney/ui/menu/navigation_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool get _isFilled => phoneController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_onChanged);
    passwordController.addListener(_onChanged);

    phoneController.text = "123123123";
    passwordController.text = "123123123";
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
      appBar: VAppBar(title: "Sign In"),
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
            "Welcome Back",
            style: textTitle1.copyWith(color: VColor.primary1),
            textAlign: TextAlign.start,
          ),
          spaceVerticalSuperSmall,
          Text("Hello there, sign in to continue", style: caption2.copyWith(color: VColor.neutral1)),
          spaceVerticalSuperLarge,
          Align(
            alignment: Alignment.center,
            child: Image.asset('$imagePath/Circle Lock.png', height: 165, fit: BoxFit.contain),
          ),
          spaceVerticalSuperLarge,
          _form(),
          spaceVerticalLarge,
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              '$iconPath/finger.svg',
              width: 64,
              height: 64,
              colorFilter: const ColorFilter.mode(VColor.primary1, BlendMode.srcIn),
            ),
          ),
          spaceVerticalLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?", style: GoogleFonts.poppins(fontSize: 12)),
              spaceHorizontalSmall,
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("Sign Up", style: caption1.copyWith(color: VColor.primary1)),
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
          spaceVerticalSmall,
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPage()));
            },
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text("Forget your password ?", style: caption2.copyWith(color: VColor.neutral4)),
            ),
          ),
          spaceVerticalCustom(40),
          SizedBox(
            width: double.infinity,
            child: VFilledButton(
              text: "Sign in",
              onPressed: _isFilled
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage()));
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
