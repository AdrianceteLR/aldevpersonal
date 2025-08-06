import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../presentation/theme/app_colors.dart';

class MonthlyTrendChart extends StatelessWidget {
  final List<TrendData> incomeData;
  final List<TrendData> expenseData;

  const MonthlyTrendChart({
    super.key,
    required this.incomeData,
    required this.expenseData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tendencia Mensual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['E', 'F', 'M', 'A', 'M', 'J'];
                          if (value.toInt() < months.length) {
                            return Text(months[value.toInt()], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: incomeData.asMap().entries.map((e) => 
                        FlSpot(e.key.toDouble(), e.value.amount)).toList(),
                      isCurved: true,
                      color: AppColors.success,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: expenseData.asMap().entries.map((e) => 
                        FlSpot(e.key.toDouble(), e.value.amount)).toList(),
                      isCurved: true,
                      color: AppColors.danger,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Ingresos', AppColors.success),
                const SizedBox(width: 24),
                _buildLegendItem('Gastos', AppColors.danger),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class TrendData {
  final String month;
  final double amount;

  TrendData({required this.month, required this.amount});
}