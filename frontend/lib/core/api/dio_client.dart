import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Vary': 'Accept',
      // },

      // send the requestwith email and password in the body of the request

    )
  );
  
  
  static void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  static void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }
}
