import 'package:flutter/material.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class MobilePrepaidPage extends StatefulWidget {
  const MobilePrepaidPage({super.key});

  @override
  State<MobilePrepaidPage> createState() => _MobilePrepaidPageState();
}

class _MobilePrepaidPageState extends State<MobilePrepaidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: VAppBar(title: "Mobile prepaid", showBack: true, primaryTheme: false));
  }
}
