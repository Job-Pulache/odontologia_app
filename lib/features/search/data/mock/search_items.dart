import 'package:flutter/material.dart';

import '../../domain/entities/search_item.dart';

final List<SearchItem> mockSearchItems = [
  SearchItem(
    title: 'Protocolo de Bioseguridad',
    category: 'Documento',
    subtitle: 'Actualización clínica 2025',
    type: 'PDF',
    icon: Icons.picture_as_pdf_outlined,
  ),

  SearchItem(
    title: 'Guía de Endodoncia',
    category: 'Biblioteca',
    subtitle: 'Procedimientos modernos',
    type: 'PDF',
    icon: Icons.menu_book_outlined,
  ),

  SearchItem(
    title: 'Congreso Nacional de Odontología',
    category: 'Evento',
    subtitle: '22 Marzo 2025',
    type: 'EVENT',
    icon: Icons.event_outlined,
  ),

  SearchItem(
    title: 'Calculadora Clínica',
    category: 'Herramienta',
    subtitle: 'Cálculo odontológico',
    type: 'TOOL',
    icon: Icons.calculate_outlined,
  ),

  SearchItem(
    title: 'Normativas CO',
    category: 'Normativa',
    subtitle: 'Reglamento institucional',
    type: 'PDF',
    icon: Icons.gavel_outlined,
  ),
];
