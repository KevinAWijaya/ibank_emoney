import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/navigation_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/clickable_field.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/success_page.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  String selectedCard = "";
  List<String> availableCard = [
    "1900 8988 5456",
    "1900 8112 5222",
    "4411 0000 1234",
    "1900 8988 5226",
    "1900 8238 5456",
  ];

  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int selectedAmount = 0;
  List<int> amountOptions = [10, 50, 100, 150, 200];
  bool _showOther = false;

  bool get _isFormValid {
    return selectedCard.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        (selectedAmount > 0 || (_showOther && amountController.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Withdraw", showBack: true, primaryTheme: false),
      body: _body(),
    );
  }

  Widget _body() {
    var screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth.clamp(350, 450);
    double w = maxWidth * 0.9;
    double h = w * 3 / 5;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginLarge),
      child: Column(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("$imagePath/Illustration 4.png"), fit: BoxFit.fitWidth),
            ),
          ),
          spaceVerticalCustom(40),
          VClickableField(
            text: selectedCard,
            hint: "Choose account/ card",
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: VColor.neutral4, size: iconSmall),
            onTap: () {
              _showAvailableBranch(context);
            },
          ),
          if (selectedCard.isNotEmpty) ...[
            spaceVerticalSuperSmall,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: marginSmall),
                child: Text("Available balance: \$10,000", style: caption1.copyWith(color: VColor.primary1)),
              ),
            ),
          ],
          spaceVerticalMedium,
          VTextField(controller: phoneController, keyboardType: TextInputType.phone, hint: "Phone number"),
          spaceVerticalLarge,
          _amountContainer(),
          Spacer(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: marginSmall),
            child: VFilledButton(
              text: "Verify",
              onPressed: _isFormValid
                  ? () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessPage(
                            image: "Illustration 4.png",
                            description:
                                "You have successfully withdrawn money!"
                                "Please check the balance in the card management section.",
                            title: "Successful withdrawal!",
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
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose amount", style: caption1.copyWith(color: VColor.grey2)),
        spaceVerticalSmall,
        _showOther
            ? VTextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                hint: "Enter amount",
                onChanged: (v) {
                  selectedAmount = int.tryParse(v) ?? 0;
                },
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: amountOptions.length + 1, // +1 for "Other"
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.3,
                ),
                itemBuilder: (context, index) {
                  if (index == amountOptions.length) {
                    // ===== Other option =====
                    bool isSelected = _showOther;
                    return _amountButton(
                      label: "Other",
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _showOther = true;
                          selectedAmount = 0;
                        });
                      },
                    );
                  } else {
                    int amount = amountOptions[index];
                    bool isSelected = selectedAmount == amount && !_showOther;
                    return _amountButton(
                      label: "\$$amount",
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedAmount = amount;
                          _showOther = false;
                          amountController.text = amount.toString();
                        });
                      },
                    );
                  }
                },
              ),
      ],
    );
  }

  Widget _amountButton({required String label, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? VColor.primary1 : VColor.neutral6,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? VColor.primary1 : VColor.neutral5, width: 1.2),
        ),
        child: Text(
          label,
          style: textBody3.copyWith(color: isSelected ? Colors.white : VColor.neutral3, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showAvailableBranch(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Choose account:", style: textTitle3),
                  spaceVerticalLarge,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => spaceVerticalMedium,
                    itemCount: availableCard.length,
                    itemBuilder: (context, index) {
                      var item = availableCard[index];
                      bool isSelected = selectedCard == item;
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, item);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Teks di tengah
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item,
                                  style: textBody1.copyWith(color: isSelected ? VColor.primary1 : VColor.grey2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Centang di kanan ujung
                              if (isSelected)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.check, color: VColor.primary1, size: 20),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  spaceVerticalLarge,
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        selectedCard = value;
        setState(() {});
      }
    });
  }
}
