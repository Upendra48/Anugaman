import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;

  final String title;

  final bool active;

  final VoidCallback onTap;

  const SidebarItem({
    super.key,

    required this.icon,

    required this.title,

    required this.onTap,

    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,

          borderRadius: BorderRadius.circular(14),
        ),

        child: Row(
          children: [
            Icon(icon, color: Colors.white),

            const SizedBox(width: 12),

            Text(
              title,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
