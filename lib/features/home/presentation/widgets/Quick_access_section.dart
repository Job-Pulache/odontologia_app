import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Accesos rápidos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              "Ver todo",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.15,
          children: const [
            QuickItem(
              color: Color(0xFFE3F2FD),
              icon: Icons.menu_book_outlined,
              title: "Biblioteca",
              subtitle: "142 recursos",
            ),

            QuickItem(
              color: Color(0xFFE8F5E9),
              icon: Icons.event_available_outlined,
              title: "Eventos",
              subtitle: "8 este mes",
            ),

            QuickItem(
              color: Color(0xFFFFF3E0),
              icon: Icons.medical_services_outlined,
              title: "Herramientas",
              subtitle: "12 disponibles",
            ),

            QuickItem(
              color: Color(0xFFF3E5F5),
              icon: Icons.badge_outlined,
              title: "Colegiatura",
              subtitle: "Vigente",
            ),
          ],
        ),
      ],
    );
  }
}

class QuickItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const QuickItem({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},

      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: AppColors.primary),
                ),

                const Spacer(),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
