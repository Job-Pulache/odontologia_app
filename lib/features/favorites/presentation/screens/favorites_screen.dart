import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/favorite_service.dart';
import '../../../library/domain/entities/document_entity.dart';
import '../../../reader/presentation/screens/reader_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final data = await FavoriteService.getFavorites();

    setState(() {
      favorites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'Aún no tienes favoritos',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),

              itemCount: favorites.length,

              separatorBuilder: (_, __) => const SizedBox(height: 14),

              itemBuilder: (context, index) {
                final title = favorites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          document: DocumentEntity(
                            title: title,
                            description: 'Documento favorito',
                            filePath: '',
                            type: '',
                            category: 'Favoritos',
                          ),
                        ),
                      ),
                    ).then((_) {
                      loadFavorites();
                    });
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
                            color: Colors.amber.withOpacity(0.15),

                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: const Icon(Icons.star, color: Colors.amber),
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
