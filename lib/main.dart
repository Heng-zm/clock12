import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for date/time formatting

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Choose a theme color
        brightness: Brightness.light, // Or Brightness.dark for a dark theme
      ),
      darkTheme: ThemeData(
        // Optional: Define a dark theme
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system, // Use system setting (light/dark)
      home: const ClockScreen(),
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late DateTime _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize time immediately
    _currentTime = DateTime.now();

    // Start a timer that ticks every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the state with the new time
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is removed from the tree
    // to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Format the time and date using the intl package
    // HH: 24-hour, hh: 12-hour, mm: minutes, ss: seconds, a: AM/PM
    // EEE: Short day name (e.g., Mon), MMMM: Full month name, d: day, y: year
    String formattedTime = DateFormat('HH:mm:ss').format(_currentTime);
    // String formattedTime12Hour = DateFormat('hh:mm:ss a').format(_currentTime); // Alternative 12-hour format
    String formattedDate = DateFormat('EEE, MMMM d, y').format(_currentTime);

    // Get screen size for potentially responsive font sizes
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clock'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: <Widget>[
            // Display Date
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 24, // Adjust font size as needed
                color:
                    Theme.of(context).colorScheme.secondary, // Use theme color
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20), // Spacing between date and time

            // Display Time
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 64, // Adjust font size as needed
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary, // Use theme color
              ),
            ),
            // Uncomment below to show 12-hour format as well
            // const SizedBox(height: 10),
            // Text(
            //   formattedTime12Hour,
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.w300,
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
