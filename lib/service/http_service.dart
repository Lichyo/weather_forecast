import 'package:dio/dio.dart';

class HTTPService {
  static const String weatherAPIKey =
      'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-3B205859-51BF-4830-9704-EA17DD5C3C31';

  Future<void> getHTTP({required String locationName}) async {
    try {
      var response = await Dio().get(weatherAPIKey);
      _isGetDataSucceed(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  bool _isGetDataSucceed(response) => response['success'];
}