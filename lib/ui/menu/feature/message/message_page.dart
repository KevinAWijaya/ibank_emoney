import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/menu/feature/message/html_message.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:ibank_emoney/ui/widgets/text_field.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  // Dummy data
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Did you attempt transaction on debit card ending in 0000 at Mechan1 in NJ for \$1,200? Reply YES or NO",
      time: DateTime(2018, 10, 8),
      isMe: false,
    ),
    ChatMessage(text: "Yes", time: DateTime(2018, 10, 8), isMe: true),
    ChatMessage(
      text:
          "Bank of America : <b>256486</b> is your authorization code which expires in 10 minutes. If you didn't request the code. Call : <b>18009898</b> for assistance",
      time: DateTime(2018, 11, 18),
      isMe: false,
    ),
    ChatMessage(text: "Thanks!", time: DateTime(2018, 11, 18), isMe: true),
    ChatMessage(text: "Are you okay?", time: DateTime.now().subtract(const Duration(hours: 2)), isMe: false),
    ChatMessage(text: "Yes", time: DateTime.now().subtract(const Duration(hours: 1)), isMe: true),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  String _formatDate(DateTime date) {
    DateTime today = DateTime.now();
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return "Today";
    }
    return DateFormat("d/MM/yyyy").format(date);
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text: _controller.text.trim(), time: DateTime.now(), isMe: true));
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Bank of America", showBack: true, primaryTheme: false),
      body: Column(
        children: [
          Expanded(child: _messageBox()),
          _inputField(),
        ],
      ),
    );
  }

  Widget _messageBox() {
    var widthPadding = MediaQuery.of(context).size.width * 0.2;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: marginLarge),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final previousMsg = index > 0 ? messages[index - 1] : null;

        bool showDateHeader = false;
        if (previousMsg == null ||
            msg.time.day != previousMsg.time.day ||
            msg.time.month != previousMsg.time.month ||
            msg.time.year != previousMsg.time.year) {
          showDateHeader = true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDateHeader)
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(_formatDate(msg.time), style: caption2.copyWith(color: VColor.neutral3)),
              ),
            Align(
              alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(msg.isMe ? widthPadding : 4, 4, !msg.isMe ? widthPadding : 4, 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: msg.isMe ? VColor.primary1 : VColor.primary4,
                  borderRadius: BorderRadius.circular(radiusLarge),
                ),
                child: !msg.isMe
                    ? HtmlMessage(htmlText: msg.text)
                    : Text(msg.text, style: textBody3.copyWith(color: VColor.neutral6)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _inputField() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginSmall),
        child: Row(
          children: [
            Expanded(
              child: VTextField(controller: _controller, hint: "Type a message..."),
            ),
            spaceHorizontalSmall,
            InkWell(
              onTap: _controller.text.trim().isEmpty ? null : _sendMessage,
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: _controller.text.trim().isEmpty ? VColor.primary4 : VColor.primary1,
                child: SvgPicture.asset(
                  "$iconPath/arrow_right.svg",
                  colorFilter: ColorFilter.mode(VColor.neutral6, BlendMode.srcIn),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final DateTime time;
  final bool isMe;

  ChatMessage({required this.text, required this.time, required this.isMe});
}
