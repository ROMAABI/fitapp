
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses & Progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Weekly Food Spending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          if (value.toInt() < titles.length) {
                             return Padding(
                               padding: const EdgeInsets.only(top: 8.0),
                               child: Text(titles[value.toInt()], style: const TextStyle(fontSize: 12)),
                             );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    _makeGroupData(0, 12),
                    _makeGroupData(1, 8.5),
                    _makeGroupData(2, 14),
                    _makeGroupData(3, 10),
                    _makeGroupData(4, 11),
                    _makeGroupData(5, 18),
                    _makeGroupData(6, 15),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 30),
            _buildSummaryCard(context),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        color: const Color(0xFF00D1C6),
        width: 16,
        borderRadius: BorderRadius.circular(4),
      ),
    ]);
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total This Week', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text('\$88.50', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
            ],
          ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Budget Left', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text('\$31.50', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
