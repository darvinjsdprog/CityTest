import 'package:city_test/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SDK {
  
  static final SDK _singleton = new SDK._internal();
  final navigatorKey = new GlobalKey<NavigatorState>();
  final _dio = new Dio();

  final String _httpUnknownErrorMsg =
      'An unexpected error has occurred, please try again.';

  final String _httpNoResponseError =
      'Could not get a response from the server. Please check your internet connection';

  factory SDK() {
    return _singleton;
  }

  SDK._internal() {
    _dio.options.baseUrl = "https://api.npoint.io";
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;
    _dio.options.contentType = "application/json; chartset=utf-8";
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (e, handler) async {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          await oneButtonsDialog(
            context: navigatorKey.currentContext!,
            title: 'Advice',
            content: _httpNoResponseError,
            button1: 'Accept',
          );
        } else {
          await oneButtonsDialog(
            context: navigatorKey.currentContext!,
            title: 'Advice',
            content: _httpUnknownErrorMsg,
            button1: 'Accept',
          );
        }

        handler.reject(e);
      },
    ));
  }

  ///Helper to do HTTP GET.
  Future<Response?> get(String url) async {
    try {
      var response = await _dio.get(
        url,
      );

      return response;
    } on DioError catch (_) {
      return null;
    } catch (e) {
      print(e);

      await oneButtonsDialog(
        context: navigatorKey.currentContext!,
        title: 'Advice',
        content: _httpUnknownErrorMsg,
        button1: 'Accept',
      );
    }

    return null;
  }

  Future<List<dynamic>> getCities() async {
    var response = await get("/5ecaa20ebea4d86084e5");
    var data = [];
    if (response != null && response.data != null) {
      data = response.data;
    }

    return data;
  }
}
