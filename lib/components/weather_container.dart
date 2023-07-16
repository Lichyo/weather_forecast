import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({
    super.key,
    required this.weatherElement,
    required this.weatherElementName,
  });

  final String weatherElement;
  final String weatherElementName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text('$weatherElementName : $weatherElement'),
    );
  }

}
