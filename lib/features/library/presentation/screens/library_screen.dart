import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/storage/document_storage_service.dart';

import '../../domain/entities/document_entity.dart';
import '../../data/mock/mock_documents.dart';

import '../../../pdf/presentation/screens/pdf_viewer_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String selectedFilter = 'Todos';
  String searchQuery = '';

  List<String> favorites = [];
  List<String> downloads = [];

  final filters = ['Todos', 'PDF', 'VIDEO', 'Offline'];

  @override
  void initState() {
    super.initState();
    loadStorage();
  }

  Future<void> loadStorage() async {
    favorites = await DocumentStorageService.getFavorites();

    downloads = await DocumentStorageService.getDownloads();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentEntity> filteredDocs;
    if (selectedFilter == 'Todos') {
      filteredDocs = mockDocuments;
    } else if (selectedFilter == 'Offline') {
      filteredDocs = mockDocuments
          .where((doc) => downloads.contains(doc.title))
          .toList();
    } else {
      filteredDocs = mockDocuments
          .where((doc) => doc.type == selectedFilter)
          .toList();
    }

    // =====================================
    // Search filters
    // =====================================

    if (searchQuery.isNotEmpty) {
      filteredDocs = filteredDocs.where((doc) {
        return doc.title.toLowerCase().contains(searchQuery) ||
            doc.description.toLowerCase().contains(searchQuery) ||
            doc.category.toLowerCase().contains(searchQuery);
      }).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================
            // HEADER
            // =====================================
            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Biblioteca Clínica',

                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Consulta protocolos, normativas y documentos oficiales.',

                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },

                    decoration: InputDecoration(
                      hintText: 'Buscar documento...',

                      prefixIcon: const Icon(Icons.search),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  GridView.count(
                    crossAxisCount: 2,

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,

                    childAspectRatio: 1.15,

                    children: [
                      categoryCard(
                        icon: Icons.health_and_safety_outlined,
                        title: 'Protocolos',
                      ),

                      categoryCard(
                        icon: Icons.menu_book_outlined,
                        title: 'Guías Clínicas',
                      ),

                      categoryCard(
                        icon: Icons.gavel_outlined,
                        title: 'Normativas',
                      ),

                      categoryCard(
                        icon: Icons.science_outlined,
                        title: 'Casos Clínicos',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    height: 40,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemCount: filters.length,

                      separatorBuilder: (_, __) => const SizedBox(width: 10),

                      itemBuilder: (context, index) {
                        final filter = filters[index];

                        final isSelected = selectedFilter == filter;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.white,

                              borderRadius: BorderRadius.circular(30),
                            ),

                            child: Text(
                              filter,

                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textPrimary,

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // =====================================
            // LISTA DOCUMENTOS
            // =====================================
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),

                itemCount: filteredDocs.length,

                separatorBuilder: (_, __) => const SizedBox(height: 16),

                itemBuilder: (context, index) {
                  final document = filteredDocs[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => PdfViewerScreen(
                            pdfUrl: document.filePath,
                            title: document.title,
                          ),
                        ),
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(24),

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
                            padding: const EdgeInsets.all(16),

                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: const Icon(
                              Icons.picture_as_pdf,

                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  document.title,

                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  document.description,

                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),

                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.08),

                                    borderRadius: BorderRadius.circular(30),
                                  ),

                                  child: Text(
                                    document.category,

                                    style: const TextStyle(
                                      color: AppColors.primary,

                                      fontWeight: FontWeight.w600,

                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await DocumentStorageService.toggleDownload(
                                    document.title,
                                  );

                                  downloads =
                                      await DocumentStorageService.getDownloads();

                                  setState(() {});
                                },

                                icon: Icon(
                                  downloads.contains(document.title)
                                      ? Icons.download_done
                                      : Icons.download_outlined,

                                  color: downloads.contains(document.title)
                                      ? AppColors.primary
                                      : null,
                                ),
                              ),

                              IconButton(
                                onPressed: () async {
                                  await DocumentStorageService.toggleFavorite(
                                    document.title,
                                  );

                                  favorites =
                                      await DocumentStorageService.getFavorites();

                                  setState(() {});
                                },

                                icon: Icon(
                                  favorites.contains(document.title)
                                      ? Icons.favorite
                                      : Icons.favorite_border,

                                  color: favorites.contains(document.title)
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryCard({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),

            blurRadius: 12,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: AppColors.primary),
          ),

          const SizedBox(height: 10),

          Text(
            title,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
