import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';

class WaterSavingChart extends StatelessWidget {
  const WaterSavingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Water Savings', style: TextStyle(fontSize: 18)),
        const Text('Last 30 days'),
        const SizedBox(height: 20),

        // Graph
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      // Dummy day labels
                      final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                      return Text(
                        dayLabels[value.toInt() % dayLabels.length],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: SColors.primary,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        SColors.primary.withOpacity(0.3),
                        SColors.primary.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  spots: const [
                    FlSpot(0, -5),
                    FlSpot(1, 10),
                    FlSpot(2, 5),
                    FlSpot(3, 12),
                    FlSpot(4, 7),
                    FlSpot(5, 15),
                    FlSpot(6, 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
