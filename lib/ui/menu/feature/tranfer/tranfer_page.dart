import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/tranfer/confirm_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/check_box.dart';
import 'package:ibank_emoney/ui/widgets/clickable_field.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';

class TranferPage extends StatefulWidget {
  const TranferPage({super.key});

  @override
  State<TranferPage> createState() => _TranferPageState();
}

class _TranferPageState extends State<TranferPage> {
  String selectedCard = "";
  List<String> availableCard = [
    "Visa **** **** **** 1234",
    "Visa **** **** **** 3456",
    "Visa **** **** **** 5678",
    "Visa **** **** **** 7891",
  ];
  int selectedTransaction = -1;
  List<TransactionType> transactionTypes = [
    TransactionType("Transfer via card number", "credit_card.svg", 0),
    TransactionType("Transfer to the same bank", "person.svg", 1),
    TransactionType("Transfer to another bank", "bank.svg", 2),
  ];
  int selectedBenefic = 0;
  List<Beneficiary> beneficiary = [
    Beneficiary(null, null, null),
    Beneficiary("Emma", "Avatar Female.png", 1),
    Beneficiary("Justin", "Avatar Male.png", 2),
    Beneficiary("Watson", "Avatar Female.png", 3),
    Beneficiary("John", "Avatar Male.png", 4),
  ];

  final _formKey = GlobalKey<FormState>();

  String selectedBank = "";
  List<String> availableBanks = [
    "Fifth Third",
    "Bank of the West",
    "Wells Fago",
    "JP Morgan Chae",
    "US bank",
    "HSBS bank",
    "Citybank",
    "Ame Express",
  ];
  String selectedBranch = "";
  List<String> availableBranch = ["New York", "Kanada", "Mexico", "Los Angeles", "Domico", "Westland"];
  TextEditingController searchController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool saveToDir = false;
  bool get _isFilled =>
      nameController.text.isNotEmpty && cardController.text.isNotEmpty && amountController.text.isNotEmpty;

  bool get _isBankFilled => selectedBank.isNotEmpty && selectedBranch.isNotEmpty;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onChanged);
    cardController.addListener(_onChanged);
    amountController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Tranfer", primaryTheme: false, showBack: true),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: marginLarge),
      child: Column(
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
              padding: const EdgeInsets.only(left: marginLarge + marginSmall),
              child: Text("Available balance : 10,000\$", style: caption1.copyWith(color: VColor.primary1)),
            ),
          spaceVerticalLarge,
          _transactionTypeContainer(),
          spaceVerticalCustom(40),
          _beneficiaryContainer(),
          spaceVerticalSuperLarge,
          _form(),
        ],
      ),
    );
  }

  Widget _transactionTypeContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginLarge),
          child: Text("Choose transaction", style: caption1.copyWith(color: VColor.grey2)),
        ),
        spaceVerticalSmall,
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: marginLarge),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => spaceHorizontalCustom(16),
            itemCount: transactionTypes.length,
            itemBuilder: (context, index) {
              return _transactionCard(transactionTypes[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _transactionCard(TransactionType transactionType) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTransaction = transactionType.id;
          });
        },
        child: Container(
          width: 120,
          height: 100,
          padding: EdgeInsets.fromLTRB(16, 16, 12, 16),
          decoration: BoxDecoration(
            color: transactionType.id == selectedTransaction
                ? (selectedTransaction == 2 ? VColor.semantic3 : VColor.primary1)
                : VColor.neutral5,
            borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
            boxShadow: [VColor.dropShadowCard],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "$iconPath/${transactionType.icon}",
                width: iconSmall,
                height: iconSmall,
                colorFilter: ColorFilter.mode(VColor.neutral6, BlendMode.srcIn),
              ),
              Spacer(),
              Text(transactionType.name, style: caption2.copyWith(color: VColor.neutral6)),
            ],
          ),
        ),
      ),
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
              Text("Choose beneficiary", style: caption1.copyWith(color: VColor.neutral3)),
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
            boxShadow: [VColor.dropShadowCard],
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginLarge),
      padding: EdgeInsets.symmetric(horizontal: marginMedium, vertical: marginLarge),
      decoration: BoxDecoration(
        color: VColor.neutral6,
        boxShadow: [VColor.dropShadowCard],
        borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedTransaction == 2) ...[
              VClickableField(
                text: selectedBank,
                hint: "Choose Bank",
                suffixIcon: selectedBank == ""
                    ? Icon(Icons.keyboard_arrow_down, color: VColor.neutral4, size: iconSmall)
                    : Icon(Icons.keyboard_arrow_right, color: VColor.neutral2, size: iconSmall),
                onTap: () {
                  _showAvailableBranch(context, "Choose beneficiary bank", selectedBank, availableBanks, 0);
                },
              ),
              spaceVerticalLarge,
              VClickableField(
                text: selectedBranch,
                hint: "Choose Branch",
                suffixIcon: selectedBranch == ""
                    ? Icon(Icons.keyboard_arrow_down, color: VColor.neutral4, size: iconSmall)
                    : Icon(Icons.keyboard_arrow_right, color: VColor.neutral2, size: iconSmall),
                onTap: () {
                  _showAvailableBranch(context, "Choose bank branch", selectedBranch, availableBranch, 1);
                },
              ),
              spaceVerticalLarge,
            ],
            VTextField(
              controller: nameController,
              hint: "Name",
              validator: (value) => (value == null || value.length < 9) ? "Enter name" : null,
            ),
            spaceVerticalLarge,
            VTextField(
              controller: cardController,
              hint: "Card number",
              validator: (value) => (value == null || value.length < 6) ? "Enter valid card" : null,
            ),
            spaceVerticalLarge,
            VTextField(
              controller: amountController,
              hint: "Amount",
              validator: (value) => (value == null || value.isEmpty) ? "Enter valid phone" : null,
            ),
            spaceVerticalLarge,
            VTextField(controller: contentController, hint: "Content"),
            spaceVerticalMedium,
            Row(
              children: [
                VCheckBox(value: saveToDir, onChanged: (v) => setState(() => saveToDir = v)),
                spaceHorizontalSmall,
                Text("Save to directory of beneficiary", style: textBody3.copyWith(color: VColor.grey2)),
              ],
            ),
            spaceVerticalSuperLarge,
            SizedBox(
              width: double.infinity,
              child: VFilledButton(
                text: "Confirm",
                onPressed: _isFilled && ((selectedTransaction == 2 && _isBankFilled) || selectedTransaction != 2)
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmationTranferPage()));
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

  void _showAvailableBranch(BuildContext context, String title, String selectedValue, List<String> items, int type) {
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
                  Text(title, style: textTitle3),
                  spaceVerticalLarge,
                  _searchBar(),
                  spaceVerticalLarge,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 1, color: VColor.grey3, height: marginExtraLarge),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, item);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: textBody1.copyWith(
                                  color: selectedValue == item ? VColor.neutral1 : VColor.grey2,
                                ),
                              ),
                            ),
                            if (selectedValue == item) ...[
                              spaceHorizontalSuperSmall,
                              Icon(Icons.check, color: VColor.primary1),
                            ],
                          ],
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
        debugPrint("selected: $value");
        if (type == 0) {
          selectedBank = value;
        } else {
          selectedBranch = value;
        }
        setState(() {});
      }
    });
  }

  Widget _searchBar() {
    return TextField(
      controller: searchController,
      style: textBody3,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: textBody3.copyWith(color: VColor.neutral4),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceHorizontalSmall,
            SvgPicture.asset(
              "$iconPath/search.svg",
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(VColor.neutral1, BlendMode.srcIn),
            ),
            spaceHorizontalSuperSmall,
          ],
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radiusLarge))),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VColor.neutral4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VColor.neutral4, width: 2),
        ),
      ),
      onChanged: (value) {
        setState(() {}); // supaya suffixIcon update
      },
    );
  }
}

class TransactionType {
  final String name;
  final String icon;
  final int id;

  TransactionType(this.name, this.icon, this.id);
}

class Beneficiary {
  final String? name;
  final String? image;
  final int? id;

  Beneficiary(this.name, this.image, this.id);
}
