import 'package:flutter/material.dart';
import 'package:odontologia_app/features/library/domain/entities/document_entity.dart';
import 'package:odontologia_app/features/reader/presentation/screens/reader_screen.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../data/mock/search_items.dart';
import '../../domain/entities/search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<SearchItem> filteredItems = mockSearchItems;

  // Corregido: Nombre consistente para la variable
  String selectedCategory = 'Todos';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    applyFilters();
  }

  void applyFilters() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredItems = mockSearchItems.where((item) {
        final matchesSearch =
            item.title.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query) ||
            item.subtitle.toLowerCase().contains(query);

        final matchesCategory =
            selectedCategory == 'Todos' ||
            item.type.toLowerCase() == selectedCategory.toLowerCase();

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  Widget buildFilterChip(String category) {
    final isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Agregado setState para refrescar el color del chip
            selectedCategory = category;
          });
          applyFilters();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
            ],
          ),
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: onSearch,
                        decoration: const InputDecoration(
                          hintText: 'Buscar documentos, eventos...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  buildFilterChip('Todos'),
                  buildFilterChip('documentos'),
                  buildFilterChip('evento'),
                  buildFilterChip('herramientas'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron resultados',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];

                        return GestureDetector(
                          onTap: () {
                            if (item.type == 'document') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ReaderScreen(
                                    document: DocumentEntity(
                                      title: item.title,
                                      description: item.subtitle,
                                      filePath:
                                          '', // Asegúrate que estos nombres existan en tu entidad
                                      type:
                                          '', // Si no, cámbialos por fileUrl o similar
                                      category: item.category,
                                    ),
                                  ),
                                ),
                              );
                            }
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
                                  child: Icon(
                                    item.icon,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
