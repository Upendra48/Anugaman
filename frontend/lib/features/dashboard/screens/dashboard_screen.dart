import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 250,

            color: AppColors.sidebar,

            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "JobTracker",

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: 28,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                sidebarItem(Icons.dashboard, "Dashboard"),

                sidebarItem(Icons.work, "Jobs"),

                sidebarItem(Icons.analytics, "Analytics"),

                sidebarItem(Icons.settings, "Settings"),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // TOP BAR
                  userAsync.when(
                    data: (user) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Welcome back, ${user.username}",

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 28,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                user.email,

                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),

                          CircleAvatar(
                            radius: 24,

                            backgroundColor: AppColors.primary,

                            child: Text(
                              user.username[0].toUpperCase(),

                              style: const TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },

                    loading: () => const CircularProgressIndicator(),

                    error: (e, _) => Text(
                      e.toString(),

                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // DASHBOARD STATS - Placeholder for now
                  Row(
                    children: [
                      statCard("Applied", "24"),

                      const SizedBox(width: 20),

                      statCard("Interviewing", "8"),

                      const SizedBox(width: 20),

                      statCard("Offers", "3"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),

      child: Row(
        children: [
          Icon(icon, color: Colors.white),

          const SizedBox(width: 12),

          Text(
            title,

            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget statCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title, style: const TextStyle(color: AppColors.textSecondary)),

            const SizedBox(height: 12),

            Text(
              value,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 32,

                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
