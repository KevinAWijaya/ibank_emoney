import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/mobile_prepaid/confirm_page.dart';
import 'package:ibank_emoney/ui/menu/feature/tranfer/tranfer_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/clickable_field.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

class MobilePrepaidPage extends StatefulWidget {
  const MobilePrepaidPage({super.key});

  @override
  State<MobilePrepaidPage> createState() => _MobilePrepaidPageState();
}

class _MobilePrepaidPageState extends State<MobilePrepaidPage> {
  String selectedCard = "";
  List<String> availableCard = [
    "Visa **** **** **** 1234",
    "Visa **** **** **** 3456",
    "Visa **** **** **** 5678",
    "Visa **** **** **** 7891",
  ];

  int selectedBenefic = 0;
  List<Beneficiary> beneficiary = [
    Beneficiary(null, null, null),
    Beneficiary("Emma", "Avatar Female.png", 1),
    Beneficiary("Justin", "Avatar Male.png", 2),
    Beneficiary("Watson", "Avatar Female.png", 3),
    Beneficiary("John", "Avatar Male.png", 4),
  ];

  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int selectedAmount = 0;
  List<int> amountOptions = [10, 50, 100, 150, 200];
  bool _showOther = false;

  final _formKey = GlobalKey<FormState>();

  bool get _isFormValid {
    return selectedCard.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        (selectedAmount > 0 || (_showOther && amountController.text.isNotEmpty));
  }

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_onChanged);
    amountController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Mobile prepaid", showBack: true, primaryTheme: false),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _amountCard(),
                  spaceVerticalLarge,
                  _beneficiaryContainer(),
                  spaceVerticalSuperLarge,
                  _form(),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: marginSmall, horizontal: marginLarge),
            child: VFilledButton(
              text: "Confirm",
              onPressed: _isFormValid
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConfirmationMobilePrepaidPage()),
                        );
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginLarge),
          child: VClickableField(
            text: selectedCard,
            hint: "Choose account / card",
            onTap: () {
              _showAvailableCard(context);
            },
            suffixIcon: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_arrow_up, size: 16, color: Colors.grey),
                Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (selectedCard != "")
          Padding(
            padding: const EdgeInsets.only(left: marginLarge + marginSmall, top: marginSuperSmall),
            child: Text("Available balance : 10,000\$", style: caption1.copyWith(color: VColor.primary1)),
          ),
      ],
    );
  }

  Widget _beneficiaryContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginLarge),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Directory", style: caption1.copyWith(color: VColor.neutral3)),
              Text("Find beneficiary", style: caption1.copyWith(color: VColor.primary1)),
            ],
          ),
        ),
        spaceVerticalSmall,
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: marginLarge),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => spaceHorizontalSmall,
            itemCount: beneficiary.length,
            itemBuilder: (context, index) {
              return _beneficiaryCard(beneficiary[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _beneficiaryCard(Beneficiary beneficiary) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedBenefic = beneficiary.id ?? 0;
          });
        },
        child: Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            color: beneficiary.id == selectedBenefic ? VColor.primary1 : VColor.neutral6,
            borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
            boxShadow: [VColor.dropShadowCardSmall],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              beneficiary.image != null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("$imagePath/${beneficiary.image}"),
                      backgroundColor: Colors.transparent,
                    )
                  : Container(
                      padding: EdgeInsets.all(marginMedium),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: VColor.primary4),
                      child: Icon(Icons.add, color: VColor.neutral6, size: 22),
                    ),
              if (beneficiary.name != null) ...[
                spaceVerticalSmall,
                Text(
                  beneficiary.name!,
                  style: caption2.copyWith(
                    color: beneficiary.id == selectedBenefic ? VColor.neutral6 : VColor.neutral1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginLarge),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VTextField(
              controller: phoneController,
              hint: "Phone number",
              label: "Phone number",
              validator: (value) => (value == null || value.length < 9) ? "Enter valid phone" : null,
            ),
            spaceVerticalLarge,
            _amountContainer(),
          ],
        ),
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

  void _showAvailableCard(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(marginLarge),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Select the currency", style: textTitle3),
                      spaceVerticalSuperLarge,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => spaceVerticalMedium,
                        itemCount: availableCard.length,
                        itemBuilder: (context, index) {
                          var card = availableCard[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context, card);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    card,
                                    style: textBody1.copyWith(
                                      color: selectedCard == card ? VColor.primary1 : VColor.grey2,
                                    ),
                                  ),
                                ),
                                if (selectedCard == card) ...[
                                  spaceHorizontalSuperSmall,
                                  Icon(Icons.check, color: VColor.primary1),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: VColor.neutral2, size: iconSmall),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        debugPrint("selected: $value");
        selectedCard = value;
        setState(() {});
      }
    });
  }
}
