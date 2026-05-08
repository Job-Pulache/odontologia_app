import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {

  double fontSize = 18;

  bool isFavorite = false;

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

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,
              ),

              child: Row(

                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Protocolo de Bioseguridad 2025',
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
                    onPressed: () {},

                    icon: const Icon(Icons.search),
                  ),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(Icons.more_vert),
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

                    Text(
                      '''
El presente protocolo establece los lineamientos obligatorios de bioseguridad para todos los profesionales colegiados del Colegio de Odontólogos.

Su aplicación tiene como objetivo garantizar la protección integral del paciente y del personal clínico durante la atención odontológica.

Las medidas aquí descritas deben implementarse de forma estricta en consultorios, clínicas y centros especializados afiliados.

Todo procedimiento deberá realizarse utilizando equipo de protección personal certificado y siguiendo estándares internacionales actualizados.

El incumplimiento de estas medidas podrá representar un riesgo sanitario significativo para pacientes y profesionales.
''',

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

                          const Icon(
                            Icons.info_outline,
                            color: Colors.amber,
                          ),

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

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

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
              onTap: () {},
            ),

            ToolbarButton(
              icon: Icons.bookmark_border,
              label: 'Marcador',
              onTap: () {},
            ),

            ToolbarButton(
              icon: isFavorite
                  ? Icons.star
                  : Icons.star_border,

              label: 'Favorito',

              onTap: () {

                setState(() {
                  isFavorite = !isFavorite;
                });
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

          Icon(
            icon,
            color: AppColors.primary,
          ),

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