import 'package:flutter/material.dart';
import 'package:ibank_emoney/ui/chart.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: BalanceChart(
            balance: 1000,
            data: [
              BalanceData(month: "Jan", positivePurple: 20, positivePink: 10, negativeRed: -15),
              BalanceData(month: "Feb", positivePurple: 130, positivePink: 15, negativeRed: -20),
              BalanceData(month: "Mar", positivePurple: 125, positivePink: 12, negativeRed: -100),
              BalanceData(month: "Apr", positivePurple: 10, positivePink: 5, negativeRed: -12),
              BalanceData(month: "May", positivePurple: 28, positivePink: 8, negativeRed: -18),
              BalanceData(month: "Jun", positivePurple: 22, positivePink: 10, negativeRed: -15),
            ],
          ),
        ),
      ),
    );
  }
}
