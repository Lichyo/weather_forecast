import 'package:dio/dio.dart';

class HTTPService {
  Future getWeatherData({required api}) async {
    try {
      var response = await Dio().get(api);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
