import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {'title': 'Misi Artemis Baru Diluncurkan', 'time': '10 Menit yang lalu'},
      {'title': 'Rover SpaceX Menemukan Jejak Air Baru', 'time': '2 Jam yang lalu'},
      {'title': 'Peluncuran Teleskop Generasi Baru Ditunda', 'time': '1 Hari yang lalu'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.campaign, color: Colors.indigo),
            title: Text(notifications[index]['title']!),
            subtitle: Text(notifications[index]['time']!),
          );
        },
      ),
    );
  }
}