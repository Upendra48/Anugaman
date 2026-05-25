import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/dashboard/services/dashboard_services.dart';

import 'package:frontend/features/dashboard/services/board_service.dart';
import 'package:frontend/features/jobs/models/column_model.dart';
import '../models/user_model.dart';
import '../../jobs/models/board_model.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  return await DashboardService.getCurrentUser();
});

final columnsProvider =

FutureProvider<List<ColumnModel>>(
  (ref) async {

    final boards =
        await BoardService.getBoards();

    final boardId =
        boards[0]["id"];

    return await BoardService
        .getColumns(boardId);
  },
);
