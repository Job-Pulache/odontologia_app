import '../../domain/entities/document_entity.dart';

final mockDocuments = [
  DocumentEntity(
    title: 'Protocolo de Bioseguridad',
    description: 'Normativas clínicas actualizadas',
    filePath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    type: 'PDF',
    category: 'Bioseguridad',
  ),

  DocumentEntity(
    title: 'Guía Clínica de Endodoncia',
    description: 'Procedimientos y tratamientos',
    filePath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    type: 'PDF',
    category: 'Endodoncia',
  ),

  DocumentEntity(
    title: 'Manual de Ortodoncia',
    description: 'Alineación y diagnóstico dental',
    filePath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    type: 'PDF',
    category: 'Ortodoncia',
  ),
];
