import 'package:flutter/material.dart';

import '../../data/mock_notifications.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notificationsMock.length,
        itemBuilder: (context, index) {
          final notification = notificationsMock[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  notification.unread
                      ? Icons.notifications_active
                      : Icons.notifications,
                ),
              ),

              title: Text(notification.title),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.description),
                  const SizedBox(height: 4),
                  Text(notification.date, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
