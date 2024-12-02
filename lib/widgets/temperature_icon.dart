import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/enums.dart';

class TemperatureIcon extends StatelessWidget {
  final double temperature;
  final Color color;
  final double size;

  const TemperatureIcon(
      {super.key, required this.temperature, required this.color, required this.size});

  //Temperature range
  TemperatureRange getTemperatureRange() {
    if (temperature < 0) {
      return TemperatureRange.freezing;
    } else if (temperature >= 0 && temperature < 10) {
      return TemperatureRange.cold;
    } else if (temperature >= 10 && temperature < 20) {
      return TemperatureRange.cool;
    } else if (temperature >= 20 && temperature < 30) {
      return TemperatureRange.warm;
    } else if (temperature >= 30 && temperature < 40) {
      return TemperatureRange.hot;
    } else {
      return TemperatureRange.scorching;
    }
  }

  //Icon based on the temperature range
  IconData getIconForTemperatureRange(TemperatureRange range) {
    switch (range) {
      case TemperatureRange.freezing:
        return Icons.ac_unit;
      case TemperatureRange.cold:
        return Icons.cloud;
      case TemperatureRange.cool:
        return Icons.wb_cloudy;
      case TemperatureRange.warm:
        return Icons.wb_sunny;
      case TemperatureRange.hot:
        return Icons.wb_sunny;
      case TemperatureRange.scorching:
        return Icons.whatshot;
    }
  }

  @override
  Widget build(BuildContext context) {
    final temperatureRange = getTemperatureRange();
    final iconData = getIconForTemperatureRange(temperatureRange);

    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}
