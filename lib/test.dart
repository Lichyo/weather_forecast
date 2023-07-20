import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  var response = await http.get(Uri.parse(
      'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-86D56E38-2EAF-4699-B807-29AD5B4B9800'));
  var data = jsonDecode(response.body);
  final weatherData = data['records']['location']; // list
  final cityWeather = searchJsonData(
    target: '臺北市',
    list: weatherData,
    queryField: 'locationName',
    askField: 'weatherElement',
  );
  final weatherElements = searchJsonData(
    target: 'Pop',
    list: cityWeather,
    queryField: 'elementName',
    askField: 'time',
  );
  final result = searchJsonData(
    target: '2023-07-28 12:00:00',
    list: weatherElements,
    queryField: 'startTime',
    askField: 'parameter',
  );
  // locationName, target, time
}

dynamic searchJsonData({
  required target,
  required List list,
  required queryField,
  required askField,
}) {
  for (var element in list) {
    if (element[queryField] == target) {
      return element[askField];
    }
  }
}