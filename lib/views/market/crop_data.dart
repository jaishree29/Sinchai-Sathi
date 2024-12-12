class CropData {
  static final List<Map<String, dynamic>> crops = [
    {
      "name": "Wheat",
      "image": "assets/images/wheat.jpeg",
      "date": "2023-10-15",
      "price": 2774.81,
      "priceChange": 50,
    },
    {
      "name": "Rice",
      "image": "assets/images/rice.jpeg",
      "date": "2023-10-14",
      "price": 3483.48,
      "priceChange": -30,
    },
    {
      "name": "Maize",
      "image": "assets/images/maize.jpeg",
      "date": "2023-10-13",
      "price": 2373.71,
      "priceChange": 20,
    },
    {
      "name": "Potato",
      "image": "assets/images/potato.jpeg",
      "date": "2023-10-12",
      "price": 2589.99,
      "priceChange": -100,
    },
    {
      "name": "Tomato",
      "image": "assets/images/tomato.jpeg",
      "date": "2023-10-11",
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
