import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BalanceChart extends StatelessWidget {
  final double balance;
  final String currency;
  final List<BalanceData> data;

  const BalanceChart({super.key, required this.balance, this.currency = "USD", required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, spreadRadius: 2, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Balance", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            "${balance.toStringAsFixed(0)} $currency",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                barGroups: _buildBarGroups(),
                gridData: FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index < 0 || index >= data.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            data[index].month,
                            style: TextStyle(
                              fontSize: 12,
                              color: index == DateTime.now().month - 1 ? Colors.indigo : Colors.grey,
                              fontWeight: index == DateTime.now().month - 1 ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final d = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: d.positivePurple + d.positivePink, // top of pink
            fromY: d.negativeRed, // ensure negative values are included
            rodStackItems: [
              // Purple segment
              BarChartRodStackItem(d.positivePink, d.positivePurple + d.positivePink, Colors.deepPurple),
              // Pink segment (stacked above purple)
              BarChartRodStackItem(0, d.positivePink, Colors.yellow),
              // Red segment (stacked downward from 0)
              if (d.negativeRed < 0) BarChartRodStackItem(0, d.negativeRed, Colors.red),
            ],
            width: 14,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    }).toList();
  }
}

class BalanceData {
  final String month;
  final double positivePurple;
  final double positivePink;
  final double negativeRed;

  BalanceData({required this.month, this.positivePurple = 0, this.positivePink = 0, this.negativeRed = 0});
}


// BalanceChart(
//             balance = 1000,
//             data = [
//               BalanceData(month: "Jan", positivePurple: 20, positivePink: 10, negativeRed: -15),
//               BalanceData(month: "Feb", positivePurple: 130, positivePink: 15, negativeRed: -20),
//               BalanceData(month: "Mar", positivePurple: 125, positivePink: 12, negativeRed: -100),
//               BalanceData(month: "Apr", positivePurple: 10, positivePink: 5, negativeRed: -12),
//               BalanceData(month: "May", positivePurple: 28, positivePink: 8, negativeRed: -18),
//               BalanceData(month: "Jun", positivePurple: 22, positivePink: 10, negativeRed: -15),
//             ],
//           ),