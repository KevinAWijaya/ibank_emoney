import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/ui/menu/tab/home_tab.dart';
import 'package:ibank_emoney/ui/menu/tab/message_tab.dart';
import 'package:ibank_emoney/ui/menu/tab/search_tab.dart';
import 'package:ibank_emoney/ui/menu/tab/setting.tab.dart';
import 'package:ibank_emoney/ui/widgets/navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<NavItem> _items = [
    NavItem(HomeTab(), "Home", "$iconPath/home.svg", "$iconPath/home_active.svg"),
    NavItem(SearchTab(), "Search", "$iconPath/search.svg", "$iconPath/search.svg"),
    NavItem(MessageTab(), "Message", "$iconPath/mail.svg", "$iconPath/mail_active.svg"),
    NavItem(SettingTab(), "Setting", "$iconPath/setting.svg", "$iconPath/setting_active.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _items[_selectedIndex].child),
      bottomNavigationBar: VNavigationBar(
        selectedIndex: _selectedIndex,
        items: _items,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}
