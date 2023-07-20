import 'package:dio/dio.dart';

class HTTPService {

  static HTTPService? _instance;
  HTTPService._();
  static HTTPService get instance {
    _instance ??= HTTPService._();
    return _instance!;
  }

  Future getWeatherData({required api}) async {
    try {
      var response = await Dio().get(api);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
