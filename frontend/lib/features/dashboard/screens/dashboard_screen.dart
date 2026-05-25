import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_spacing.dart';

import '../widgets/sidebar_item.dart';

import '../../jobs/widgets/kanban_column.dart';

import '../../jobs/widgets/job_card.dart';

import '../providers/dashboard_provider.dart';

import '../../jobs/widgets/create_job_dialog.dart';

import '../../jobs/services/job_service.dart';
import '../../jobs/providers/job_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final columnsAsync = ref.watch(columnsProvider);

    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 260,

            padding: const EdgeInsets.all(AppSpacing.lg),

            decoration: const BoxDecoration(
              color: AppColors.sidebar,

              border: Border(right: BorderSide(color: AppColors.border)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // LOGO
                const Row(
                  children: [
                    Icon(
                      Icons.work_outline,

                      color: AppColors.primary,

                      size: 32,
                    ),

                    SizedBox(width: 12),

                    Text(
                      "JobTracker",

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 24,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxl),

                // NAVIGATION
                SidebarItem(
                  icon: Icons.dashboard_outlined,

                  title: "Dashboard",

                  active: selectedIndex == 0,

                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),

                SidebarItem(
                  icon: Icons.work_outline,

                  title: "Applications",

                  active: selectedIndex == 1,

                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),

                SidebarItem(
                  icon: Icons.analytics_outlined,

                  title: "Analytics",

                  active: selectedIndex == 2,

                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),

                SidebarItem(
                  icon: Icons.settings_outlined,

                  title: "Settings",

                  active: selectedIndex == 3,

                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                ),

                const Spacer(),

                // USER PROFILE
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),

                  decoration: BoxDecoration(
                    color: AppColors.card,

                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,

                        backgroundColor: AppColors.primary,

                        child: Text(
                          "U",

                          style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Upendra",

                              style: TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Backend Dev",

                              style: TextStyle(
                                color: AppColors.textSecondary,

                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // TOP NAVBAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Dashboard",

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 32,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            "Track and manage your applications",

                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),

                      // SEARCH + NOTIFICATIONS
                      Row(
                        children: [
                          Container(
                            width: 280,

                            padding: const EdgeInsets.symmetric(horizontal: 16),

                            decoration: BoxDecoration(
                              color: AppColors.card,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: const TextField(
                              style: TextStyle(color: Colors.white),

                              decoration: InputDecoration(
                                hintText: "Search...",

                                hintStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),

                                border: InputBorder.none,

                                icon: Icon(
                                  Icons.search,

                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: AppSpacing.md),

                          Container(
                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: AppColors.card,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: const Icon(
                              Icons.notifications_none,

                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // STATS SECTION
                  Row(
                    children: [
                      statCard("Applications", "24", Icons.work_outline),

                      const SizedBox(width: AppSpacing.lg),

                      statCard("Interviews", "8", Icons.groups_outlined),

                      const SizedBox(width: AppSpacing.lg),

                      statCard("Offers", "3", Icons.local_offer_outlined),

                      const SizedBox(width: AppSpacing.lg),

                      statCard("Rejected", "5", Icons.close),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // KANBAN BOARD
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),

                      decoration: BoxDecoration(
                        color: AppColors.sidebar,

                        borderRadius: BorderRadius.circular(24),
                      ),

                      child: columnsAsync.when(
                        data: (columns) {
                          return jobsAsync.when(
                            data: (jobs) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: columns.length,

                                itemBuilder: (context, index) {
                                  final column = columns[index];

                                  final columnJobs = jobs.where((job) {
                                    return job.status.toLowerCase() ==
                                        column.title.toLowerCase();
                                  }).toList();

                                  return KanbanColumn(
                                    title: column.title,

                                    jobs: columnJobs.map((job) {
                                      return JobCard(
                                        company: job.company,

                                        position: job.position,

                                        location: job.location,

                                        status: job.status,
                                      );
                                    }).toList(),
                                  );
                                },
                              );
                            },

                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),

                            error: (e, _) => Center(
                              child: Text(
                                e.toString(),

                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        },

                        loading: () =>
                            const Center(child: CircularProgressIndicator()),

                        error: (e, _) => Center(
                          child: Text(
                            e.toString(),

                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  title,

                  style: const TextStyle(color: AppColors.textSecondary),
                ),

                Icon(icon, color: AppColors.primary),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

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
