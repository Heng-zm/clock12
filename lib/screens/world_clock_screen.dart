import 'package:flutter/material.dart';

class WorldClockScreen extends StatefulWidget {
  const WorldClockScreen({super.key});

  @override
  State<WorldClockScreen> createState() => _WorldClockScreenState();
}

class _WorldClockScreenState extends State<WorldClockScreen> {
  // TODO: Implement World Clock Logic
  // - List to hold selected cities/timezones
  // - Load/Save selections (shared_preferences or sqflite)
  // - Use 'timezone' package to get locations and calculate current time
  // - Use 'flutter_native_timezone' to get local timezone easily
  // - UI to display clocks (ListView.builder)
  // - UI to search/add new cities/timezones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'World Clock Feature Placeholder',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to Add City Screen or show Search Dialog
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add City functionality TBD')));
        },
        tooltip: 'Add City',
        child: const Icon(Icons.add_location_alt_outlined),
      ),
    );
  }
}
