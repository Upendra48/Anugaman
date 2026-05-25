import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_spacing.dart';

import 'job_card.dart';

class KanbanColumn
    extends StatelessWidget {

  final String title;

  final List<JobCard> jobs;

  const KanbanColumn({

    super.key,

    required this.title,

    required this.jobs,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 340,

      margin:
          const EdgeInsets.only(
        right: AppSpacing.lg,
      ),

      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(

        color: AppColors.sidebar,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Text(

                title,

                style: const TextStyle(

                  color: Colors.white,

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(

                  color: AppColors.card,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: Text(

                  jobs.length.toString(),

                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Expanded(

            child: ListView(

              children: jobs,
            ),
          ),
        ],
      ),
    );
  }
}