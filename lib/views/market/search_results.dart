// search_results.dart

import 'package:flutter/material.dart';
import 'crop_item.dart';

class SearchResults extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const SearchResults({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: results.map((crop) {
        return CropItem(
          image: crop["image"],
          name: crop["name"],
          date: crop["date"],
          price: crop["price"],
          priceChange: crop["priceChange"],
        );
      }).toList(),
    );
  }
}
