import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/history_service.dart';
import '../../../../core/storage/history_item.dart';
import '../../../reader/presentation/screens/reader_screen.dart';
import '../../../library/domain/entities/document_entity.dart';

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
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final history = snapshot.data!;

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

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReaderScreen(
                        document: DocumentEntity(
                          title: item.title,
                          description: item.category,
                          filePath: '',
                          type: '',
                          category: item.category,
                        ),
                      ),
                    ),
                  );
                },

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

                      const Icon(Icons.chevron_right),
                    ],
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
