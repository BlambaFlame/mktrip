import 'package:flutter/material.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  List<String> list = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.notifications_sharp),
              title: Text(list[index]),
              subtitle: const Text('This is a notification'),
            ),
          );
        },
      ),
    );
  }
}
