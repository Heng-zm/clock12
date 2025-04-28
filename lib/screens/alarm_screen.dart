import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // TODO: Implement Alarm Logic
  // - List to hold alarms
  // - Load/Save alarms (using sqflite or shared_preferences)
  // - Schedule notifications (flutter_local_notifications, workmanager)
  // - UI to display alarms (ListView.builder)
  // - FloatingActionButton to add new alarm -> Navigate to edit screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Alarm Feature Placeholder',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to Add/Edit Alarm Screen
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add Alarm functionality TBD')));
        },
        tooltip: 'Add Alarm',
        child: const Icon(Icons.add_alarm),
      ),
    );
  }
}
