import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    const String cropName = "Paddy Basmati";
    const String date = "30 Nov 2024";
    const String location = "Gurugram";
    const String price = "₹2135/Q";
    const String changePercentage = "+0.48%";

    // Past prices data
    final List<Map<String, dynamic>> pastPrices = [
      {"day": "Mon", "price": "₹2120", "change": "+0.42%"},
      {"day": "Tue", "price": "₹2115", "change": "+0.30%"},
      {"day": "Wed", "price": "₹2130", "change": "+0.55%"},
      {"day": "Thu", "price": "₹2135", "change": "+0.48%"},
      {"day": "Fri", "price": "₹2128", "change": "-0.33%"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Price"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Name, Date, and Location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  cropName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "$date | $location",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current Price and Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price: $price",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  changePercentage,
                  style: TextStyle(
                    fontSize: 16,
                    color: changePercentage.startsWith("+")
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Price Trend Heading
            const Text(
              "Price Trend",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Graph and Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2710, 1 week $changePercentage",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              TextStyle style = TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              );
                              switch (value.toInt()) {
                                case 0:
                                  return Text('Mon', style: style);
                                case 1:
                                  return Text('Tue', style: style);
                                case 2:
                                  return Text('Wed', style: style);
                                case 3:
                                  return Text('Thu', style: style);
                                case 4:
                                  return Text('Fri', style: style);
                                default:
                                  return Text('', style: style);
                              }
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 2120),
                            FlSpot(1, 2115),
                            FlSpot(2, 2130),
                            FlSpot(3, 2135),
                            FlSpot(4, 2128),
                          ],
                          isCurved: true,
                          color: SColors.primary,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: SColors.primary.withOpacity(0.2),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Past Prices Heading
            const Text(
              "Past Prices",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Past Prices List
            Expanded(
              child: ListView.builder(
                itemCount: pastPrices.length,
                itemBuilder: (context, index) {
                  final data = pastPrices[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        // Icon with Background
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: SColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              const Icon(Icons.trending_up, color: SColors.primary),
                        ),
                        const SizedBox(width: 16),

                        // Day and Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['day'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                data['price'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),

                        // Change Percentage
                        Text(
                          data['change'],
                          style: TextStyle(
                            fontSize: 14,
                            color: data['change'].startsWith("+")
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
