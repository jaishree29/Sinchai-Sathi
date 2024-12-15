import 'package:intl/intl.dart';

var formattedDate = DateFormat.yMd().format(DateTime.now());

class CropData {
  static final List<Map<String, dynamic>> crops = [
    {
      "name": "Wheat",
      "image": "assets/images/wheat.jpeg",
      "date": formattedDate,
      "price": 2774.81,
      "priceChange": 50,
    },
    {
      "name": "Rice",
      "image": "assets/images/rice.jpeg",
      "date": formattedDate,
      "price": 3483.48,
      "priceChange": -30,
    },
    {
      "name": "Maize",
      "image": "assets/images/maize.jpeg",
      "date": formattedDate,
      "price": 2373.71,
      "priceChange": 20,
    },
    {
      "name": "Potato",
      "image": "assets/images/potato.jpeg",
      "date": formattedDate,
      "price": 2589.99,
      "priceChange": -100,
    },
    {
      "name": "Tomato",
      "image": "assets/images/tomato.jpeg",
      "date": formattedDate,
      "price": 3180.2,
      "priceChange": 150,
    },
  ];

  static List<Map<String, dynamic>> searchCrops(String query) {
    return crops
        .where(
          (crop) => crop["name"].toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }
}
