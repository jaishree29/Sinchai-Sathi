import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:intl/intl.dart';

class CropPriceScreen extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final int priceChange;

  const CropPriceScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.priceChange,
  });

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('d MMM yyyy').format(DateTime.now());

    // Sample data
    const String location = "Kalkheda, Bhopal";
    final String priceText = "₹${price.toStringAsFixed(0)}/Q";
    final String changePercentage =
        "${priceChange >= 0 ? '+' : ''}${priceChange}%";

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
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "$currentDate | $location",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current Price and Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price: $priceText",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  changePercentage,
                  style: TextStyle(
                    fontSize: 16,
                    color: priceChange >= 0 ? Colors.green : Colors.red,
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
                          child: const Icon(Icons.trending_up,
                              color: SColors.primary),
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
