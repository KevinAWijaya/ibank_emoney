import 'package:flutter/material.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';

class SettingTab extends StatefulWidget {
  final VoidCallback? onBack;
  const SettingTab({super.key, this.onBack});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Setting", primaryTheme: false, onBackPressed: widget.onBack, showBack: true),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Container();
  }
}
