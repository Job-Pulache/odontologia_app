import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/reading_history_service.dart';
import '../../../library/domain/entities/document_entity.dart';
import '../../../reader/presentation/screens/reader_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await ReadingHistoryService.getHistory();

    setState(() {
      history = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text('Historial de Lectura'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: history.isEmpty
          ? const Center(
              child: Text(
                'No hay historial todavía',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),

              itemCount: history.length,

              separatorBuilder: (_, __) => const SizedBox(height: 14),

              itemBuilder: (context, index) {
                final title = history[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          document: DocumentEntity(
                            title: title,
                            description: 'Historial',
                            filePath: '',
                            type: '',
                            category: 'Lectura',
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

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                        ),
                      ],
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
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
