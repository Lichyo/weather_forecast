import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() => runApp(const WeatherForecast());

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
