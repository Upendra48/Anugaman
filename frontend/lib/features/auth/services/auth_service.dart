import 'package:dio/dio.dart';

import '../../../core/api/dio_client.dart';

class AuthService {
  static Future<String> login({
    required String email,

    required String password,
  }) async {
    DioClient.clearAuthToken();
    try {
      final response = await DioClient.dio.post(
        "/auth/login/",

        data: {"email": email, "password": password},
      );

      print("Login response: ${response.data}");

      final access_token = response.data["access_token"];

      // Stored for later use (e.g., token refresh)
      final refresh_token = response.data["refresh_token"];
      DioClient.setAuthToken(access_token);
      
      return access_token;
} on DioException catch (e) {

  print("STATUS CODE: ${e.response?.statusCode}");

  print("RESPONSE DATA: ${e.response?.data}");

  print("ERROR: ${e.message}");

  throw Exception(
    e.response?.data.toString() ??
    "Login failed",
  );
}
  }
}
