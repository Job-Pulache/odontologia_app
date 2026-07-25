import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../widgets/Home_header.dart';
import '../widgets/Hero_banner.dart';
import '../widgets/Quick_access_section.dart';

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
              // =========================
              // HEADER
              // =========================
              const HomeHeader(),
              const HeroBanner(),
              // =========================
              // ACCESOS RAPIDOS
              // =========================
              const QuickAccessSection(),
              // =========================
              // CONTINUAR LEYENDO
              // =========================
              const SectionHeader(
                title: 'Continuar Leyendo',
                action: 'Ver más',
              ),

              const SizedBox(height: AppSpacing.md),

              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: const Icon(
                            Icons.description_outlined,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            'Guía Clínica de Endodoncia',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        const Text(
                          '65%',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: const LinearProgressIndicator(
                        value: 0.65,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE5E7EB),
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Capítulo 4 de 7',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // =========================
              // ULTIMOS COMUNICADOS
              // =========================
              const SectionHeader(
                title: 'Últimos Comunicados',
                action: 'Ver todo',
              ),

              const SizedBox(height: AppSpacing.md),

              const Column(
                children: [
                  NewsCard(
                    title: 'Nuevo Reglamento de Ética',
                    date: '12 Mar 2025',
                  ),

                  SizedBox(height: 14),

                  NewsCard(
                    title: 'Renovación de Colegiatura 2025',
                    date: '08 Mar 2025',
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // =========================
              // PROXIMOS EVENTOS
              // =========================
              const SectionHeader(
                title: 'Próximos Eventos',
                action: 'Ver todo',
              ),

              const SizedBox(height: AppSpacing.md),

              SizedBox(
                height: 160,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: const [
                    EventMiniCard(
                      title: 'Congreso Nacional de Odontología',
                      location: 'Lima Convention Center',
                      date: '22 Mar',
                    ),

                    SizedBox(width: 14),

                    EventMiniCard(
                      title: 'Taller de Implantología Avanzada',
                      location: 'Sede Central CO',
                      date: '05 Abr',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// SECTION HEADER
// ======================================================

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  const SectionHeader({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        Text(
          action,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ======================================================
// QUICK ACCESS CARD
// ======================================================

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

            child: Icon(icon, color: AppColors.primary),
          ),

          const Spacer(),

          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

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

// ======================================================
// NEWS CARD
// ======================================================

class NewsCard extends StatelessWidget {
  final String title;
  final String date;

  const NewsCard({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Icon(Icons.feed_outlined, color: AppColors.primary),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

// ======================================================
// EVENT MINI CARD
// ======================================================

class EventMiniCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;

  const EventMiniCard({
    super.key,
    required this.title,
    required this.location,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,

      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

            const Spacer(),

            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
