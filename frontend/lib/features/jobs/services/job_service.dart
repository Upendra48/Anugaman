import 'package:dio/dio.dart';

import '../../../core/api/dio_client.dart';

import '../models/job_model.dart';

class JobService {

  static Future<List<JobModel>>
      getJobs() async {

    try {

      final response =
          await DioClient.dio.get(
        "/jobs/",
      );

      final results =
          response.data["results"];

      return (results as List)

          .map(
            (job) =>
                JobModel.fromJson(job),
          )

          .toList();

    } on DioException catch (e) {

      throw Exception(

        e.response?.data.toString() ??
        "Failed to fetch jobs",
      );
    }
  }
}