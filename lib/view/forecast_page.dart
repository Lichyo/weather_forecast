import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather.dart';
import 'package:weather_forecast/components/pop_container.dart';
import 'package:weather_forecast/components/temp_container.dart';

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
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                TempContainer(
                  title: 'Min Temp',
                  temp: _weather.minT,
                ),
                const VerticalDivider(
                  thickness: 1,
                ),
                TempContainer(
                  title: 'Max Temp',
                  temp: _weather.maxT,
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
                PopContainer(
                  pop: _weather.pop,
                ),
                const VerticalDivider(
                  thickness: 1,
                ),
                // ci
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('舒適度', textAlign: TextAlign.right,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
