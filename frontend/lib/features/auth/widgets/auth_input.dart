import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthInput extends StatelessWidget {

  final String hint;

  final TextEditingController controller;

  final bool obscure;

  const AuthInput({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),

        filled: true,

        fillColor: AppColors.card,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}