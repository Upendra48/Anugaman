import 'package:dio/dio.dart';

import '../../../core/api/dio_client.dart';
import '../../jobs/models/board_model.dart';
import '../../jobs/models/column_model.dart';
import '../models/user_model.dart';

class DashboardService {
  static Future<UserModel> getCurrentUser() async {
    try {
      final response = await DioClient.dio.get("/auth/me/");

      return UserModel.fromJson({
        "id": response.data["user_id"],
        "username": response.data["username"],
        "email": response.data["email"],
      });
    } on DioException catch (e) {
      throw Exception(
        e.response?.data.toString() ?? "Failed to fetch current user",
      );
    }
  }


}
