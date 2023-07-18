import 'package:weather_forecast/service/http_service.dart';
import 'dart:convert';
import 'weather.dart';
import 'package:flutter/material.dart';

class WeatherBrain {
  static const String weatherAPIKey =
      'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-3B205859-51BF-4830-9704-EA17DD5C3C31';
  final HTTPService _httpService = HTTPService();

  Weather defaultWeather() => Weather(
        locationName: '臺北市',
        wx: '',
        pop: 0,
        minT: 0,
        maxT: 0,
        ci: '',
      );

  Future getWeatherData({required String locationName}) async {
    final data = await _httpService.getWeatherData(api: weatherAPIKey);
    final response = jsonDecode(data.toString());
    final weathers = response["records"]['location'];
    for (var weather in weathers) {
      if (weather['locationName'] == locationName) {
        final weatherElements = weather['weatherElement'];

        List<Weather> weatherData = [];
        for (int i = 0; i < 3; i++) {
          String wx = '';
          int pop = 0;
          double minT = 0;
          double maxT = 0;
          String ci = '';
          for (var weatherElement in weatherElements) {
            if (weatherElement['elementName'] == 'Wx') {
              wx = weatherElement['time'][i]['parameter']['parameterName'];
            }
            if (weatherElement['elementName'] == 'PoP') {
              pop = int.parse(
                  weatherElement['time'][i]['parameter']['parameterName']);
            }
            if (weatherElement['elementName'] == 'MinT') {
              minT = double.parse(
                  weatherElement['time'][i]['parameter']['parameterName']);
            }
            if (weatherElement['elementName'] == 'MaxT') {
              maxT = double.parse(
                  weatherElement['time'][i]['parameter']['parameterName']);
            }
            if (weatherElement['elementName'] == 'CI') {
              ci = weatherElement['time'][i]['parameter']['parameterName'];
            }
          }
          weatherData.add(
            Weather(
              locationName: locationName,
              wx: wx,
              pop: pop,
              minT: minT,
              maxT: maxT,
              ci: ci,
            ),
          );
        }
        if (weatherData.isNotEmpty) {
          return weatherData;
        } else {
          throw Exception(
              'there is not Data, please check wifi or whether the city name is corrected');
        }
      }
    }
  }

  Image determineTempImage(double temp) {
    if (temp <= 10) {
      return Image.asset('images/temp_icon/10ºC.png');
    } else if (temp <= 20) {
      return Image.asset('images/temp_icon/20ºC.png');
    } else if (temp <= 25) {
      return Image.asset('images/temp_icon/25ºC.png');
    } else if (temp <= 30) {
      return Image.asset('images/temp_icon/30ºC.png');
    } else {
      return Image.asset('images/temp_icon/35ºC.png');
    }
  }

  Image determinePOPImage(int pop) {
    if (pop <= 30) {
      return Image.asset('images/pop_icon/sun.png');
    } else if (pop <= 40) {
      return Image.asset('images/pop_icon/cloudy.png');
    } else if (pop <= 60) {
      return Image.asset('images/pop_icon/clouds.png');
    } else if (pop <= 80) {
      return Image.asset('images/pop_icon/rain.png');
    } else {
      return Image.asset('images/pop_icon/storm.png');
    }
  }
}
