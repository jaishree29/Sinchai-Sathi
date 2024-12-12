import 'package:flutter/material.dart';
import 'crop_data.dart';
import 'crop_item.dart';
import 'search_results.dart';

class MarketPriceScreen extends StatefulWidget {
  const MarketPriceScreen({super.key});

  @override
  State<MarketPriceScreen> createState() => _MarketPriceScreenState();
}

class _MarketPriceScreenState extends State<MarketPriceScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _performSearch(String query) {
    setState(() {
      _searchResults = CropData.searchCrops(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for crops...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
          // Search Results or Default List
          Expanded(
            child: _searchResults.isNotEmpty
                ? SearchResults(results: _searchResults)
                : ListView(
                    children: CropData.crops.map((crop) {
                      return CropItem(
                        image: crop["image"],
                        name: crop["name"],
                        date: crop["date"],
                        price: crop["price"],
                        priceChange: crop["priceChange"],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
