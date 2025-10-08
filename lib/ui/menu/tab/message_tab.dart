import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/message/message_page.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class MessageTab extends StatefulWidget {
  final VoidCallback? onBack;

  const MessageTab({super.key, this.onBack});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Message", primaryTheme: false, onBackPressed: widget.onBack, showBack: true),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(marginLarge),
      child: Column(
        children: [
          _messageCard(
            "Bank of America",
            "Bank of America : 256486 is your authorization code which expires in 10 minutes. If you didn't request the code. Call : 18009898 for assistance",
            "bank.svg",
            "Today",
            VColor.primary1,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
            },
          ),
          _messageCard(
            "Account",
            "Your account is limited. Please follow for more",
            "person.svg",
            "12/10",
            VColor.semantic1,
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => InterestRatePage()));
            },
          ),
          _messageCard(
            "Alert",
            "Your statement is ready for you to exchange",
            "phone_message.svg",
            "11/10",
            VColor.semantic2,
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ExchangeRatePage()));
            },
          ),
          _messageCard(
            "Paypal",
            "Your account has been locked. Please contact us",
            "paypal.svg",
            "10/11",
            VColor.semantic3,
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ExchangePage()));
            },
          ),
          _messageCard(
            "Withdraw",
            "Dear customer, 2987456 is your co...",
            "credit_card_in.svg",
            "10/12",
            VColor.semantic4,
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ExchangePage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _messageCard(String title, String desc, String image, String time, Color bgColor, {void Function()? onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
            color: VColor.neutral6,
            boxShadow: [VColor.dropShadowCardSmall],
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
                  color: bgColor,
                ),
                child: SvgPicture.asset(
                  '$iconPath/$image',
                  height: 20,
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(VColor.neutral6, BlendMode.srcIn),
                ),
              ),
              spaceHorizontalMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textBody1),
                    Text(
                      desc,
                      style: caption1.copyWith(color: VColor.neutral3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              spaceHorizontalMedium,
              Text(time, style: caption2.copyWith(color: VColor.neutral3)),
            ],
          ),
        ),
      ),
    );
  }
}
