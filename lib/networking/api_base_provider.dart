import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_revenue_flutter/util/app_exceptions.dart';

class ApiBaseProvider {
  final String _baseUrl = "http://67.205.181.63:8081/";
  BaseOptions baseOptions = BaseOptions(
    connectTimeout: 3000,
  );

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await Dio(baseOptions).get(
        _baseUrl + url,
      );
      responseJson = _response(response);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      return null;
    } on DioError catch (e) {
      print("Error is $e");
      return null;
    }
    return responseJson;
  }

  Future<dynamic> post(String url, final body) async {
    baseOptions.connectTimeout = 3000;
    var responseJson;
    try {
      var dio = Dio();
      dio.options.connectTimeout = 5000;
      final response = await dio.post(_baseUrl + url, data: body);
      responseJson = _response(response);
    } on SocketException catch (e) {
      print("Error is $e");
      return null;
    } on DioError catch (e) {
      print("Error is $e");
      return null;
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorisedException(response.data.toString());
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw ServerException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
