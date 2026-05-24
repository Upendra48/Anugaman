import 'package:flutter/material.dart';
import 'package:frontend/core/storage/token_storage.dart';
import 'package:frontend/features/auth/services/auth_service.dart';

import '../../../core/theme/app_colors.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final token = await AuthService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await TokenStorage.saveToken(
        token,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
          duration: Duration(seconds: 2),
        ),
      );

      // TODO: Navigate to home/dashboard screen
      print("✅ Login successful. Token set in DioClient.");
    } on Exception catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: AppColors.card,

              borderRadius: BorderRadius.circular(24),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Welcome Back",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Track your job journey.",

                  style: TextStyle(color: AppColors.textSecondary),
                ),

                const SizedBox(height: 32),

                AuthInput(hint: "Email", controller: emailController),

                const SizedBox(height: 16),

                AuthInput(
                  hint: "Password",
                  controller: passwordController,
                  obscure: true,
                ),

                const SizedBox(height: 24),

                AuthButton(text: "Login", onPressed: login),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
