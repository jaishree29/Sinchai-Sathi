import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/home/crop_detail.dart'; // Import the CropDetail screen

class AboutCropsScreen extends StatelessWidget {
  const AboutCropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Crop data as a Map
    final Map<String, String> cropData = {
      'Potato':
          'https://images.unsplash.com/photo-1518977676651-b471f97c9079?w=500&auto=format&fit=crop&q=60',
      'Wheat':
          'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=500&auto=format&fit=crop&q=60',
      'Tomato':
          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500&auto=format&fit=crop&q=60',
      'Lettuce':
          'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=500&auto=format&fit=crop&q=60',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Crops"),
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: cropData.length,
          itemBuilder: (context, index) {
            final cropEntry = cropData.entries.elementAt(index);
            final cropName = cropEntry.key;
            final cropImage = cropEntry.value;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropDetail(title: cropName),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(cropImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      cropName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
