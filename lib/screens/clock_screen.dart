import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart'; // Import the package
import '../providers/settings_provider.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late DateTime _currentTime;
  Timer? _timer; // Make timer nullable

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    // Start a timer that ticks every second only if it's not already running
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        // Check if the widget is still in the tree
        timer.cancel();
        return;
      }
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer safely
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access settings from the provider
    final settings = Provider.of<SettingsProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String formattedTime =
        DateFormat(settings.intlTimeFormat).format(_currentTime);
    String formattedDate = DateFormat('EEE, MMMM d, y').format(_currentTime);

    return Center(
      child: SingleChildScrollView(
        // Added for flexibility if content grows
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // --- Analog Clock ---
            SizedBox(
              width: 250,
              height: 250,
              child: AnalogClock(
                // Customize the appearance
                dateTime: _currentTime, // Use state variable
                isKeepTime: false, // We update manually via state
                hourNumberColor: Theme.of(context).colorScheme.onSurface,
                hourHandColor: Theme.of(context).colorScheme.primary,
                minuteHandColor: Theme.of(context).colorScheme.primary,
                secondHandColor: Theme.of(context).colorScheme.secondary,
                dialBorderColor: Theme.of(context).colorScheme.outline,
                dialColor: Theme.of(context).colorScheme.surface,
                centerPointColor: Theme.of(context).colorScheme.primary,
                // Use dark mode settings if needed
                // dialBorderColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                // dialColor: isDarkMode ? Colors.grey[850] : Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            // --- Digital Clock ---
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 50, // Slightly smaller to fit with analog
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              key:
                  ValueKey(settings.timeFormat), // Rebuilds when format changes
            ),
            const SizedBox(height: 40), // Add some bottom padding
          ],
        ),
      ),
    );
  }
}
