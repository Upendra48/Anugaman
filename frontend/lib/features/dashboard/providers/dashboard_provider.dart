import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/dashboard/services/dashboard_services.dart';

import '../models/user_model.dart';

final currentUserProvider =

FutureProvider<UserModel>((ref) async {

  return await DashboardService
      .getCurrentUser();
});