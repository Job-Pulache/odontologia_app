import '../domain/entities/document_entity.dart';

final mockDocuments = [
  DocumentEntity(
    id: '1',
    title: 'Protocolo de Bioseguridad 2025',
    category: 'Protocolos',
    content: '''
El presente protocolo establece los lineamientos obligatorios de bioseguridad para todos los profesionales colegiados del Colegio de Odontólogos.

Su aplicación tiene como objetivo garantizar la protección integral del paciente y del personal clínico durante la atención odontológica.

Las medidas aquí descritas deben implementarse de forma estricta en consultorios y clínicas odontológicas.
''',
  ),

  DocumentEntity(
    id: '2',
    title: 'Guía Clínica de Ortodoncia',
    category: 'Guías Clínicas',
    content: '''
La ortodoncia moderna requiere protocolos especializados para garantizar diagnósticos precisos y tratamientos eficientes.
''',
  ),

  DocumentEntity(
    id: '3',
    title: 'Normativa de Atención Dental',
    category: 'Normativas',
    content: '''
Toda institución odontológica colegiada deberá cumplir con estándares nacionales actualizados.
''',
  ),
];
