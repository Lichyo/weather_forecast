import 'package:flutter/material.dart';

void main() => runApp(WeatherForecast());

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  String locationName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      onChanged: (value) {
                        locationName = value;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: '請輸入城市名稱',
                        // errorText: '尚未輸入城市名稱',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        //TODO: 確認送出查詢資料
                      },
                      child: const Text('確認'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
