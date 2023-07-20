import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  return runApp(
    const WeatherForecast(),
  );
}

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
