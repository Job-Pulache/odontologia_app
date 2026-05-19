import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/history_service.dart';
import '../../../../core/storage/history_item.dart';
import '../../../../core/storage/favorite_service.dart';

import '../../../history/presentation/screens/history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<HistoryItem> recentHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await HistoryService.getHistory();

    setState(() {
      recentHistory = data.take(3).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // =====================================
              // HEADER
              // =====================================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),

                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpUqorzGvPIkBcSmuqqCmVr8-cG4z4mA57BQ&s',
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Dr. Juan Carlos Pérez',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Ortodoncia y Rehabilitación Oral',
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 18),

                          SizedBox(width: 8),

                          Text(
                            'Colegiado Activo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // =====================================
              // INFO CARD
              // =====================================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Column(
                  children: [
                    ProfileInfoTile(
                      icon: Icons.badge_outlined,
                      title: 'Número de Colegiatura',
                      value: 'COL-12345',
                    ),

                    Divider(height: 30),

                    ProfileInfoTile(
                      icon: Icons.school_outlined,
                      title: 'Especialidad',
                      value: 'Ortodoncia',
                    ),

                    Divider(height: 30),

                    ProfileInfoTile(
                      icon: Icons.calendar_month_outlined,
                      title: 'Fecha de Colegiatura',
                      value: '15/03/2018',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // =====================================
              // FAVORITOS
              // =====================================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Favoritos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...FavoriteService.getFavorites().map(
                      (favorite) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),

                        child: FavoriteTile(
                          title: favorite.title,
                          subtitle: favorite.category,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ACTIVIDAD
              // =====================================
              const SizedBox(height: 24),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Actividad Reciente',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HistoryScreen(),
                              ),
                            );
                          },

                          child: const Text('Ver todo'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    recentHistory.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),

                            child: Center(
                              child: Text(
                                'Aún no hay actividad reciente',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: recentHistory.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),

                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),

                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                      ),

                                      child: const Icon(
                                        Icons.history,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            item.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,

                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            item.category,

                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),

              // =====================================
              //            // OPCIONES
              // =====================================
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.settings_outlined,
                      title: 'Configuración',
                    ),

                    Divider(height: 1),

                    SettingsTile(
                      icon: Icons.download_outlined,
                      title: 'Mis Descargas',
                    ),

                    Divider(height: 1),

                    SettingsTile(
                      icon: Icons.logout,
                      title: 'Cerrar Sesión',
                      isLogout: true,
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

// =====================================
// PROFILE INFO TILE
// =====================================

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: AppColors.primary),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================
// FAVORITE TILE
// =====================================

class FavoriteTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const FavoriteTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),

            child: const Icon(Icons.star, color: Colors.amber),
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
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================
// SETTINGS TILE
// =====================================

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : AppColors.primary),

      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),

      trailing: const Icon(Icons.chevron_right),
    );
  }
}
