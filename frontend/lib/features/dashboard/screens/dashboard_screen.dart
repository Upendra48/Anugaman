import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DashboardScreen
    extends StatelessWidget {

  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,

      appBar: AppBar(

        backgroundColor:
            AppColors.sidebar,

        title:
            const Text("Dashboard"),
      ),

      body: const Center(

        child: Text(

          "Authenticated User",

          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}