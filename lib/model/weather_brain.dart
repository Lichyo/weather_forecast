import 'package:weather_forecast/service/http_service.dart';
import 'dart:convert';
import 'weather.dart';

class WeatherBrain {
  static const String weatherAPIKey =
      'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-3B205859-51BF-4830-9704-EA17DD5C3C31';
  final HTTPService _httpService = HTTPService();
  Future initWeatherData({required String locationName}) async {
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
}
