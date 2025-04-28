import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // TODO: Implement Timer Logic
  // - State for duration, remaining time, running status
  // - UI to set duration (Number pickers or text fields)
  // - UI to display remaining time
  // - Buttons for Start, Pause, Reset
  // - Use Timer.periodic for countdown
  // - Optionally: notification when done

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Timer Feature Placeholder',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
