import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(AppSpacing.md),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Bienvenido',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Hola, Dr. Ramírez',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.notifications_none,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // BANNER
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Comunicado Oficial',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Actualización del Reglamento de Ética 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ACCESOS RAPIDOS
              const Text(
                'Accesos rápidos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,

                children: const [

                  QuickAccessCard(
                    icon: Icons.menu_book_outlined,
                    title: 'Biblioteca Clínica',
                    subtitle: '142 recursos',
                  ),

                  QuickAccessCard(
                    icon: Icons.event_outlined,
                    title: 'Eventos Académicos',
                    subtitle: '8 este mes',
                  ),

                  QuickAccessCard(
                    icon: Icons.medical_services_outlined,
                    title: 'Herramientas',
                    subtitle: '12 utilidades',
                  ),

                  QuickAccessCard(
                    icon: Icons.badge_outlined,
                    title: 'Mi Colegiatura',
                    subtitle: 'Vigente',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAccessCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;

  const QuickAccessCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return AppCard(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}