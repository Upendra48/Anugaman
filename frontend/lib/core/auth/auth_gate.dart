import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';

import '../../features/auth/screens/login_screen.dart';

import '../../features/dashboard/screens/dashboard_screen.dart';

class AuthGate
    extends ConsumerStatefulWidget {

  const AuthGate({
    super.key,
  });

  @override
  ConsumerState<AuthGate>
      createState() =>
          _AuthGateState();
}

class _AuthGateState
    extends ConsumerState<AuthGate> {

  bool loading = true;

  @override
  void initState() {

    super.initState();

    checkAuth();
  }

  Future<void> checkAuth()
  async {

    await ref
        .read(authProvider.notifier)
        .checkAuthStatus();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),
        ),
      );
    }

    final authenticated =
        ref.watch(authProvider);

    if (authenticated) {

      return const DashboardScreen();
    }

    return const LoginScreen();
  }
}