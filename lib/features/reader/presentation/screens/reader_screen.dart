import 'package:flutter/material.dart';
import '../../../../core/storage/local_storage_service.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/library/domain/entities/document_entity.dart';
//import '../../domain/entities/document_entity.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/storage/favorites_service.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final DocumentEntity document;

  const ReaderScreen({super.key, required this.document});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  double fontSize = 18;
  final String documentContent = '''

El presente protocolo establece los lineamientos obligatorios de bioseguridad para todos los profesionales colegiados del Colegio de Odontólogos.

Su aplicación tiene como objetivo garantizar la protección integral del paciente y del personal clínico durante la atención odontológica.

Las medidas aquí descritas deben implementarse de forma estricta en consultorios, clínicas y centros especializados afiliados.

Todo procedimiento deberá realizarse utilizando equipo de protección personal certificado y siguiendo estándares internacionales actualizados.

El incumplimiento de estas medidas podrá representar un riesgo sanitario significativo para pacientes y profesionales.

''';
  final chapters = [
    'Introducción',
    'Medidas de Bioseguridad',
    'Protección del Paciente',
    'Uso de Instrumental',
    'Procedimientos Clínicos',
    'Manejo de Residuos',
    'Normativas Finales',
  ];

  bool isFavorite = false;
  bool isBookmarked = false;
  List<String> searchResults = [];
  final List<String> notes = [];

  final TextEditingController noteController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    loadBookmark();
    Future<void> loadFavorite() async {
      final value = await FavoritesService.isFavorite(widget.document.title);

      setState(() {
        isFavorite = value;
      });
    }

    loadFavorite();
  }

  Future<void> loadBookmark() async {
    final value = await LocalStorageService.getBookmark();

    setState(() {
      isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================
            // HEADER
            // =====================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

              decoration: const BoxDecoration(color: Colors.white),

              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          widget.document.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Capítulo 2 de 7',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,

                        isScrollControlled: true,

                        backgroundColor: Colors.transparent,

                        builder: (_) {
                          return StatefulBuilder(
                            builder: (context, setModalState) {
                              return Container(
                                height: 650,

                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(
                                    context,
                                  ).viewInsets.bottom,
                                ),

                                decoration: const BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),

                                child: Column(
                                  children: [
                                    const SizedBox(height: 14),

                                    Container(
                                      width: 60,
                                      height: 6,

                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),

                                      child: Align(
                                        alignment: Alignment.centerLeft,

                                        child: Text(
                                          'Buscar en el documento',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),

                                      child: TextField(
                                        controller: searchController,

                                        decoration: InputDecoration(
                                          hintText: 'Buscar palabra o frase...',

                                          prefixIcon: const Icon(Icons.search),

                                          filled: true,

                                          fillColor: const Color(0xFFF5F7FA),

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),

                                            borderSide: BorderSide.none,
                                          ),
                                        ),

                                        onChanged: (value) {
                                          searchResults.clear();

                                          if (value.trim().isEmpty) {
                                            setModalState(() {});
                                            return;
                                          }

                                          final paragraphs = documentContent
                                              .split('\n');

                                          for (var paragraph in paragraphs) {
                                            if (paragraph
                                                .toLowerCase()
                                                .contains(
                                                  value.toLowerCase(),
                                                )) {
                                              searchResults.add(paragraph);
                                            }
                                          }

                                          setModalState(() {});
                                        },
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    Expanded(
                                      child: searchResults.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'Sin resultados',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            )
                                          : ListView.separated(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                  ),

                                              itemCount: searchResults.length,

                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(height: 14),

                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                    18,
                                                  ),

                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFFF8FAFC,
                                                    ),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),

                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,

                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  10,
                                                                ),

                                                            decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                    0.1,
                                                                  ),

                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),

                                                            child: const Icon(
                                                              Icons.search,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            width: 12,
                                                          ),

                                                          const Text(
                                                            'Coincidencia',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        height: 14,
                                                      ),

                                                      Text(
                                                        searchResults[index],

                                                        style: const TextStyle(
                                                          height: 1.7,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },

                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(darkModeProvider.notifier).state = !ref.read(
                        darkModeProvider,
                      );
                    },

                    icon: Icon(
                      ref.watch(darkModeProvider)
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                  ),
                ],
              ),
            ),

            // =====================================
            // PROGRESS BAR
            // =====================================
            const LinearProgressIndicator(
              value: 0.35,
              minHeight: 4,
              color: AppColors.primary,
              backgroundColor: Color(0xFFE5E7EB),
            ),

            // =====================================
            // CONTENT
            // =====================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Introducción',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 24),

                    SelectableText.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: fontSize,
                          height: 1.9,
                          color: AppColors.textPrimary,
                        ),

                        children: [
                          const TextSpan(
                            text:
                                'El presente protocolo establece los lineamientos obligatorios de bioseguridad para todos los profesionales colegiados del Colegio de Odontólogos.\n\n',
                          ),

                          TextSpan(
                            text:
                                'Su aplicación tiene como objetivo garantizar la protección integral del paciente y del personal clínico durante la atención odontológica.\n\n',

                            style: TextStyle(
                              backgroundColor: Colors.yellow.withOpacity(0.35),
                            ),
                          ),

                          const TextSpan(
                            text:
                                'Las medidas aquí descritas deben implementarse de forma estricta en consultorios, clínicas y centros especializados afiliados.\n\n',
                          ),

                          TextSpan(
                            text:
                                'Todo procedimiento deberá realizarse utilizando equipo de protección personal certificado y siguiendo estándares internacionales actualizados.\n\n',

                            style: TextStyle(
                              backgroundColor: Colors.green.withOpacity(0.20),
                            ),
                          ),

                          const TextSpan(
                            text:
                                'El incumplimiento de estas medidas podrá representar un riesgo sanitario significativo para pacientes y profesionales.',
                          ),
                        ],
                      ),

                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.9,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.3),
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Icon(Icons.info_outline, color: Colors.amber),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              'El uso obligatorio de mascarilla N95 será requerido durante procedimientos de alto riesgo biológico.',

                              style: TextStyle(
                                fontSize: fontSize - 1,
                                height: 1.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================
      // FLOATING TOOLBAR
      // =====================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            ToolbarButton(
              icon: Icons.menu_book_outlined,
              label: 'Índice',

              onTap: () {
                showModalBottomSheet(
                  context: context,

                  backgroundColor: Colors.transparent,

                  builder: (_) {
                    return Container(
                      height: 500,

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),

                      child: Column(
                        children: [
                          const SizedBox(height: 14),

                          Container(
                            width: 60,
                            height: 6,

                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),

                            child: Align(
                              alignment: Alignment.centerLeft,

                              child: Text(
                                'Índice del Documento',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Expanded(
                            child: ListView.separated(
                              itemCount: chapters.length,

                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),

                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    width: 36,
                                    height: 36,

                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),

                                      borderRadius: BorderRadius.circular(12),
                                    ),

                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  title: Text(
                                    chapters[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  trailing: const Icon(Icons.chevron_right),

                                  onTap: () {
                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Abriendo: ${chapters[index]}',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            ToolbarButton(
              icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,

              label: 'Marcador',

              onTap: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });

                LocalStorageService.saveBookmark(isBookmarked);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,

                    backgroundColor: Colors.black87,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    content: Text(
                      isBookmarked
                          ? 'Marcador guardado correctamente'
                          : 'Marcador eliminado',

                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),

            ToolbarButton(
              icon: isFavorite ? Icons.star : Icons.star_border,

              label: 'Favorito',

              onTap: () async {
                await FavoritesService.toggleFavorite(widget.document.title);

                final updated = await FavoritesService.isFavorite(
                  widget.document.title,
                );

                setState(() {
                  isFavorite = updated;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,

                    backgroundColor: Colors.black87,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    content: Text(
                      isFavorite
                          ? 'Documento agregado a favoritos'
                          : 'Documento eliminado de favoritos',

                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),

            ToolbarButton(
              icon: Icons.edit_note_outlined,
              label: 'Notas',

              onTap: () {
                showModalBottomSheet(
                  context: context,

                  isScrollControlled: true,

                  backgroundColor: Colors.transparent,

                  builder: (_) {
                    return StatefulBuilder(
                      builder: (context, setModalState) {
                        return Container(
                          height: 650,

                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),

                          decoration: const BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),

                          child: Column(
                            children: [
                              const SizedBox(height: 14),

                              Container(
                                width: 60,
                                height: 6,

                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                              const SizedBox(height: 24),

                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),

                                child: Align(
                                  alignment: Alignment.centerLeft,

                                  child: Text(
                                    'Notas del Documento',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: noteController,

                                        decoration: InputDecoration(
                                          hintText: 'Escribir nota clínica...',

                                          filled: true,

                                          fillColor: const Color(0xFFF5F7FA),

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    GestureDetector(
                                      onTap: () {
                                        if (noteController.text
                                            .trim()
                                            .isEmpty) {
                                          return;
                                        }

                                        setState(() {
                                          notes.add(noteController.text);
                                        });

                                        setModalState(() {});

                                        noteController.clear();
                                      },

                                      child: Container(
                                        padding: const EdgeInsets.all(16),

                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),

                                        child: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              Expanded(
                                child: notes.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'Aún no hay notas',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),

                                        itemCount: notes.length,

                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 14),

                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(18),

                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF8FAFC),

                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),

                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,

                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),

                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.1),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),

                                                  child: const Icon(
                                                    Icons.sticky_note_2,
                                                    color: AppColors.primary,
                                                  ),
                                                ),

                                                const SizedBox(width: 14),

                                                Expanded(
                                                  child: Text(
                                                    notes[index],

                                                    style: const TextStyle(
                                                      height: 1.6,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

            ToolbarButton(
              icon: Icons.text_fields,
              label: 'Texto',

              onTap: () {
                showModalBottomSheet(
                  context: context,

                  builder: (_) {
                    return Container(
                      padding: const EdgeInsets.all(24),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Tamaño de Texto',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 24),

                          Slider(
                            value: fontSize,
                            min: 14,
                            max: 30,

                            onChanged: (value) {
                              setState(() {
                                fontSize = value;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================
// TOOLBAR BUTTON
// =========================================

class ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ToolbarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(icon, color: AppColors.primary),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
