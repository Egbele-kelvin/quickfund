import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quickfund/util/sharedPreference.dart';

import 'ApiInterception.dart';
import 'interception.dart';

class ApiManager {
  // static String baseURL ='https://www.google.com';
  static String baseURL = 'http://13.59.82.31';
  // static String baseURL = 'http://staging.quickfund.rimotechnology.com';
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  String token;
  Map<String, String> headers;

  static Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  )..interceptors.add(Logging());

  getTokenPref() async {
    token = await _sharedPreferenceQS.getSharedPrefs(String, 'token');
    print('token $token');
    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    print('headers: $headers');
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await _dio.get(
        baseURL + url,
        options: Options(
          headers: headers,
          // sendTimeout:  60*1000, // 60 seconds
          // receiveTimeout: 60*1000 //
        ),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print('error $e');
    }

    return responseJson;
  }

  Future<Map<String, dynamic>> post(String url, body) async {
    var responseJson;
    await getTokenPref();

    try {
      Response userData = await _dio.post(
        baseURL + url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      // print('SignInResp: \n  ${userData.data} \n');

      responseJson = _response(userData);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response.statusCode}');
        print('DATA: ${e.response.data}');
        print('HEADERS: ${e.response.headers}');
        responseJson = _response(e.response);
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    var tokenExp = {"response_code": "06"};
    print('yawa o ${response.data}');
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.toString());
        return responseJson;

      case 400:
        var responseJson = json.decode(response.toString());
        print('Error 400 here: $responseJson');
        return responseJson;

        case 401:
        var responseJson = json.decode(tokenExp.toString());
        print('Me here: $responseJson');
        return responseJson;

        case 422:
        var responseJson = json.decode(response.toString());
        print('shitty Error LameAss 422:   $responseJson');
        return responseJson;

        case 423:
        var responseJson = json.decode(response.toString());
        print('shitty Error LameAss 423:   $responseJson');
        return responseJson;

      default:
        var responseJson = json.decode(response.toString());
        // print(response);
        return responseJson;
    }
  }
}
