import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../search/presentation/screens/search_screen.dart';

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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(Icons.search, size: 24),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none, size: 26),

                        Positioned(
                          right: 0,
                          top: 0,

                          child: Container(
                            width: 8,
                            height: 8,

                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1F5AA6), Color(0xFF4DA6FF)],
                  ),

                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: const Row(
                            children: [
                              Icon(
                                Icons.campaign_outlined,
                                color: Colors.white,
                                size: 16,
                              ),

                              SizedBox(width: 6),

                              Text(
                                'Nuevo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        const Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Comunicado Oficial',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Actualización del Reglamento de Ética 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // =========================
              // ACCESOS RAPIDOS
              // =========================
              const SectionHeader(title: 'Accesos Rápidos', action: 'Ver todo'),

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

              const SizedBox(height: AppSpacing.xl),

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
