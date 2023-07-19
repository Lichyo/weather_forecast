import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather.dart';
import 'package:weather_forecast/components/pop_container.dart';
import 'package:weather_forecast/components/temp_container.dart';
import 'package:weather_forecast/components/ci_container.dart';
import 'package:weather_forecast/model/weather_brain.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({
    super.key,
    required Weather weather,
  }) : _weather = weather;

  final Weather _weather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    _weather.locationName,
                    style: const TextStyle(
                      fontFamily: 'cute',
                      fontSize: 45.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: WeatherBrain().determineMeanTAnimation(
                    maxT: _weather.maxT,
                    minT: _weather.minT,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0,),
                  child: Text(
                    _weather.wx,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'cute',
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 30.0,
            ),
            child: Divider(
              thickness: 1,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                TempContainer(
                  title: 'Min Temp',
                  temp: _weather.minT,
                ),
                const SizedBox(
                  width: 10,
                ),
                TempContainer(
                  title: 'Max Temp',
                  temp: _weather.maxT,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                PopContainer(
                  pop: _weather.pop,
                ),
                const SizedBox(
                  width: 10,
                ),
                CiContainer(
                  ci: _weather.ci,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
