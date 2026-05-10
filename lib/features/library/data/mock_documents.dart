import '../domain/entities/document_entity.dart';

final mockDocuments = [
  const DocumentEntity(
    title: 'Protocolo de Bioseguridad 2025',
    category: 'Protocolos',
    type: 'PDF',
    description: 'Lineamientos oficiales de bioseguridad clínica odontológica.',
    filePath: 'assets/pdfs/bioSegurity.pdf',
  ),

  const DocumentEntity(
    title: 'Guía Clínica de Endodoncia',
    category: 'Guías Clínicas',
    type: 'PDF',
    description: 'Procedimientos y recomendaciones actualizadas de endodoncia.',
    filePath: 'assets/pdfs/endodoncia.pdf',
  ),

  const DocumentEntity(
    title: 'Protocolo de Bioseguridad 2025',
    category: 'Protocolos',
    type: 'PDF',
    description: 'Lineamientos oficiales de bioseguridad clínica odontológica.',
    filePath: 'assets/pdfs/bioseguridad.pdf',
  ),

  const DocumentEntity(
    title: 'Caso Clínico: Ortodoncia',
    category: 'Casos Clínicos',
    type: 'VIDEO',
    description: 'Análisis clínico completo de tratamiento ortodóntico.',
    filePath: 'assets/videos/ortodoncia.mp4',
  ),
];
