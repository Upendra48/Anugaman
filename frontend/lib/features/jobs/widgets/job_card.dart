import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_spacing.dart';

class JobCard extends StatelessWidget {
  final String company;

  final String position;

  final String location;

  final String status;

  const JobCard({
    super.key,

    required this.company,

    required this.position,

    required this.location,

    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: AppColors.primary,

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Text(
                  status,

                  style: const TextStyle(
                    color: Colors.white,

                    fontSize: 12,

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(Icons.more_horiz, color: AppColors.textSecondary),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            position,

            style: const TextStyle(
              color: Colors.white,

              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            company,

            style: const TextStyle(
              color: AppColors.textSecondary,

              fontSize: 15,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,

                size: 18,

                color: AppColors.textSecondary,
              ),

              const SizedBox(width: 6),

              Text(
                location,

                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
