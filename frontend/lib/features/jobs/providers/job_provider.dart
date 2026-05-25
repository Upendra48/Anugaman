import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/job_model.dart';

import '../services/job_service.dart';

final jobsProvider =

FutureProvider<List<JobModel>>(
  (ref) async {

    return await JobService
        .getJobs();
  },
);