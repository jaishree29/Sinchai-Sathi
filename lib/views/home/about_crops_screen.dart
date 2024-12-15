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
          'https://img.freepik.com/free-photo/potatoes-closeup-as-background-top-view_176474-2023.jpg?t=st=1733073128~exp=1733076728~hmac=13ef1c000f3c3f3965d6a0f8ac680aef83fa1d8479fe4bac691d65801cb7b8d0&w=1380',
      'Wheat':
          'https://img.freepik.com/free-photo/wheat-field-waving-wind-field-background_1268-30583.jpg?t=st=1733072854~exp=1733076454~hmac=2fdb9a6de8021d4fd68337284ca5f68a90754cbdc9144b01b8fc41ecfb265542&w=1380',
      'Tomato':
          'https://img.freepik.com/free-photo/fresh-wet-tomatoes_144627-24355.jpg?t=st=1733073240~exp=1733076840~hmac=65cd6adca0d75b9b2d0347a5b5b5b327dee0e4afe0773c3ed2b37d004c942424&w=740',
      'Lettuce':
          'https://img.freepik.com/free-photo/lettuce-closeup-texture-background_144627-30014.jpg?t=st=1733073423~exp=1733077023~hmac=83d298b4eb9e64eb6cbe578e9bb986e629eefccd8ee1c6df8c9d20f20f1b4de2&w=1380',
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
