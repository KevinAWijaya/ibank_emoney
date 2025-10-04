import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/auth/forgot_password/change_page.dart';
import 'package:ibank_emoney/ui/menu/feature/app_information_page.dart';
import 'package:ibank_emoney/ui/menu/feature/language_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class SettingTab extends StatelessWidget {
  final VoidCallback? onBack;
  const SettingTab({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: VAppBar(title: "Setting", showBack: true, onBackPressed: onBack),
      backgroundColor: VColor.primary1,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLarge)),
              color: VColor.neutral6,
            ),
            child: Column(
              children: [
                spaceVerticalCustom(50 + marginSmall),
                Text("Push Puttichai", style: textTitle3.copyWith(color: VColor.primary1)),
                spaceVerticalLarge,
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                    children: [
                      _buildMenuItem(
                        "Password",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePasswordPage(fromProfile: true)),
                          );
                        },
                      ),
                      _buildMenuItem("Touch ID"),
                      _buildMenuItem(
                        "Languages",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
                        },
                      ),
                      _buildMenuItem(
                        "App information",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AppInformationPage()));
                        },
                      ),
                      _buildMenuItem("Customer care", trailing: "19008989"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 15,
            left: screenWidth / 2 - 50,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('$imagePath/Avatar Male.png', height: 100, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {String? trailing, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textBody1),
            trailing != null
                ? Text(trailing, style: caption1.copyWith(color: VColor.grey2))
                : const Icon(Icons.chevron_right, color: VColor.neutral5),
          ],
        ),
      ),
    );
  }
}
