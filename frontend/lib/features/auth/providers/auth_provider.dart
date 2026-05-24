import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/api/dio_client.dart';
import '../../../core/storage/token_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  bool get isAuthenticated => state;

  Future<void> checkAuthStatus() async {
    final token = await TokenStorage.getToken();

    if (token != null) {
      DioClient.setAuthToken(token);

      state = true;
    } else {
      state = false;
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearToken();

    DioClient.clearAuthToken();

    state = false;
  }

  void login() {
    state = true;
  }
}
