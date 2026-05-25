import 'package:dio/dio.dart';

import '../../../core/api/dio_client.dart';

import '../../jobs/models/column_model.dart';

class BoardService {

  static Future<List<dynamic>>
      getBoards() async {

    try {

      final response =
          await DioClient.dio.get(
        "/boards/",
      );

      return response.data;

    } on DioException catch (e) {

      throw Exception(

        e.response?.data.toString() ??
        "Failed to fetch boards",
      );
    }
  }

  static Future<List<ColumnModel>>
      getColumns(
    String boardId,
  ) async {

    try {

      final response =
          await DioClient.dio.get(
        "/boards/$boardId/columns",
      );

      return (response.data as List)

          .map(
            (column) =>
                ColumnModel.fromJson(
                    column),
          )

          .toList();

    } on DioException catch (e) {

      throw Exception(

        e.response?.data.toString() ??
        "Failed to fetch columns",
      );
    }
  }
}