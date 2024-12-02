import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, String> event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  EventCard(
      {required this.event, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['name'] ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tanggal: ${event['date'] ?? ''}'),
            Text('Jam: ${event['time'] ?? ''}'),
            Text('Lokasi: ${event['location'] ?? ''}'),
            Text('Deskripsi: ${event['description'] ?? ''}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
