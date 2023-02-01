import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:webviewtest/services/app_exceptions.dart';

class DioClient {
  static const int timeOutDuration = 20;

  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await Dio()
          .get(baseUrl + api,
          options: Options(headers: {"Content-Type": "application/json"}))
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException(
            'API not responded in time', uri.toString());
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', uri.toString());
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('Not found exception', uri.toString());
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', uri.toString());
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await Dio()
          .post(baseUrl + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // OTHER
  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
