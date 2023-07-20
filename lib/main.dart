import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'model/weather_brain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final weatherBrainProvider = Provider<WeatherBrain>((ref) => WeatherBrain());
  return runApp(
    const ProviderScope(
      child: WeatherForecast(),
    ),
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
