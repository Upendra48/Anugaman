import 'package:dio/dio.dart';

import '../../../core/api/dio_client.dart';

import '../models/user_model.dart';

class DashboardService {

  static Future<UserModel>
      getCurrentUser() async {

    try {

      final response =
          await DioClient.dio.get(

        "/auth/me/",
      );

      return UserModel.fromJson(
        response.data["user"],
      );

    } on DioException catch (e) {

      throw Exception(

        e.response?.data.toString() ??
        "Failed to fetch user",
      );
    }
  }
}