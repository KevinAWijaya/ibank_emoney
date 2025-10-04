import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class BalanceChart extends StatelessWidget {
  final double balance;
  final String currency;
  final List<BalanceData> data;

  const BalanceChart({super.key, required this.balance, this.currency = "USD", required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: marginLarge),
      decoration: BoxDecoration(
        color: VColor.neutral6,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [VColor.dropShadowCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Balance", style: caption1),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w500, color: VColor.primary1),
              children: [
                TextSpan(text: balance.toStringAsFixed(0)),
                TextSpan(
                  text: " $currency",
                  style: caption1.copyWith(color: VColor.grey2),
                ),
              ],
            ),
          ),
          spaceVerticalLarge,
          SizedBox(
            height: 200,
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
              BarChartRodStackItem(d.positivePink, d.positivePurple + d.positivePink, VColor.primary1),
              // Pink segment (stacked above purple)
              BarChartRodStackItem(0, d.positivePink, VColor.semantic7),
              // Red segment (stacked downward from 0)
              if (d.negativeRed < 0) BarChartRodStackItem(0, d.negativeRed, VColor.semantic6),
            ],
            width: 8,
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
