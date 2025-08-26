import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';

class BuildInfoCard extends StatelessWidget {
  const BuildInfoCard({super.key, required this.icon, required this.title, required this.value});
  final String title;
  final String value;
  final IconData icon;
  @override

  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    value.isNotEmpty ? value : "-",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
