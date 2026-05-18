import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/history_service.dart';
import '../../../../core/storage/history_item.dart';
import '../../../reader/presentation/screens/reader_screen.dart';
import '../../../library/domain/entities/document_entity.dart';
import '../../../pdf/presentation/screens/pdf_viewer_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text('Historial de Lectura'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: FutureBuilder<List<HistoryItem>>(
        future: HistoryService.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(
              child: Text(
                'Aún no hay lecturas recientes',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),

            itemCount: history.length,

            separatorBuilder: (_, __) => const SizedBox(height: 14),

            itemBuilder: (context, index) {
              final item = history[index];

              return Dismissible(
                key: Key(item.title + index.toString()),

                direction: DismissDirection.endToStart,

                background: Container(
                  alignment: Alignment.centerRight,

                  padding: const EdgeInsets.symmetric(horizontal: 24),

                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                onDismissed: (_) async {
                  await HistoryService.removeHistory(item.title);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Documento eliminado del historial'),
                    ),
                  );
                },

                child: GestureDetector(
                  onTap: () {},

                  child: Container(
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),

                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),

                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: const Icon(
                            Icons.history,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                item.title,

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                item.category,

                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
