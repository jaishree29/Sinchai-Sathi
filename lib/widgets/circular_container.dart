import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/home/crop_detail.dart';

class SCircularContainer extends StatelessWidget {
  const SCircularContainer({super.key, required this.title, required this.image});

  final String title;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropDetail(title: title),
        ),
      ),
      child: CircleAvatar(
        radius: 40,
        foregroundColor: SColors.primary.withOpacity(0.3),
        backgroundImage: image,
        backgroundColor: SColors.primary.withOpacity(0.3),
      ),
    );
  }
}
