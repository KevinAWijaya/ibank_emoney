import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/filled_button.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String fromCurrency = "USD";
  String toCurrency = "USD";

  @override
  void initState() {
    super.initState();
    fromController.addListener(_onChanged);
    toController.addListener(_onChanged);
  }

  final List<Currency> currencyList = [
    Currency("VND", "Viet Nam Dong"),
    Currency("HK\$", "Hong Kong Dollar"),
    Currency("USD", "Dollar"),
    Currency("NT\$", "Taiwan Dollar"),
    Currency("J\$", "Jamaika Dollar"),
  ];

  Currency selectedCurrency = Currency("USD", "Dollar");

  bool get _isFilled => fromController.text.isNotEmpty || toController.text.isNotEmpty;

  void _onChanged() => setState(() {});

  void swapCurrencies() {
    setState(() {
      final tempAmount = fromController.text;
      fromController.text = toController.text;
      toController.text = tempAmount;

      final tempCurrency = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = tempCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Exchange", primaryTheme: false, showBack: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _body()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(width: double.infinity, color: VColor.neutral6),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 300, maxWidth: 400, maxHeight: 300),
          alignment: Alignment.center,
          child: SvgPicture.asset("$iconPath/Illustration 5.svg", width: double.infinity, fit: BoxFit.fitWidth),
        ),
        spaceVerticalSuperLarge,
        _form(),
      ],
    );
  }

  Widget _form() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: marginMedium, vertical: marginLarge),
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMax),
          boxShadow: [VColor.dropShadowCard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _currencyField("From", fromController, fromCurrency),
            spaceVerticalMedium,
            GestureDetector(
              onTap: swapCurrencies,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "$iconPath/arrow_down.svg",
                    width: iconSmall,
                    height: iconSmall,
                    colorFilter: ColorFilter.mode(VColor.primary1, BlendMode.srcIn),
                  ),
                  spaceHorizontalSuperSmall,
                  SvgPicture.asset(
                    "$iconPath/arrow_up.svg",
                    width: iconSmall,
                    height: iconSmall,
                    colorFilter: ColorFilter.mode(VColor.semantic1, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            spaceVerticalMedium,
            _currencyField("To", toController, toCurrency),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: marginSmall),
              height: 64,
              child: Visibility(
                visible: _isFilled,
                child: Row(
                  children: [
                    Text("Currency rate", style: textBody3.copyWith(color: VColor.primary1)),
                    Spacer(),
                    Text("1 USD = 1122 KRW", style: textBody3),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: VFilledButton(text: "Exchange", onPressed: _isFilled ? () {} : null),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currencyField(String label, TextEditingController controller, String currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: caption1.copyWith(color: VColor.grey2)),
        spaceVerticalSuperSmall,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: VColor.grey1),
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: textBody3,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      hintStyle: textBody3.copyWith(color: VColor.neutral4),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                VerticalDivider(color: VColor.grey1, thickness: 1),
                InkWell(
                  onTap: () {
                    _showCustomDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: marginMedium),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currency,
                          style: textBody1.copyWith(
                            color: controller.text.isNotEmpty ? VColor.neutral1 : VColor.neutral4,
                          ),
                        ),
                        spaceHorizontalSmall,
                        SvgPicture.asset(
                          "$iconPath/arrow_up_down.svg",
                          colorFilter: ColorFilter.mode(VColor.neutral2, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCustomDialog(BuildContext context) {
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
                        itemCount: currencyList.length,
                        itemBuilder: (context, index) {
                          var currency = currencyList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context, currency.code);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${currency.code} ( ${currency.name} )",
                                    style: textBody1.copyWith(
                                      color: selectedCurrency.code == currency.code ? VColor.primary1 : VColor.grey2,
                                    ),
                                  ),
                                ),
                                if (selectedCurrency.code == currency.code) ...[
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
      }
    });
  }
}

class Currency {
  final String name;
  final String code;
  Currency(this.code, this.name);
}
