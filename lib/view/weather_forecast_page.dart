import 'package:flutter/material.dart';
import 'package:weather_forecast/components/weather_container.dart';
import 'package:weather_forecast/model/weather.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          WeatherContainer(
            weatherElement: weather.locationName,
            weatherElementName: 'location',
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.black,
              height: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
