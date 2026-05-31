import '../domain/notification_model.dart';

final notificationsMock = [
  const AppNotification(
    title: 'Nuevo evento disponible',
    description: 'Congreso Internacional de Odontología 2026',
    date: 'Hace 2 horas',
    unread: true,
  ),

  const AppNotification(
    title: 'Documento actualizado',
    description: 'Protocolo de Bioseguridad v2.1',
    date: 'Hace 1 día',
  ),

  const AppNotification(
    title: 'Comunicado oficial',
    description: 'Nueva normativa institucional',
    date: 'Hace 2 días',
  ),

  const AppNotification(
    title: 'Recordatorio de evento',
    description: 'Taller de Endodoncia mañana',
    date: 'Hace 3 días',
  ),
];
