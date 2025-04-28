import 'package:flutter/material.dart';
import 'dart:async'; // Need for Stopwatch logic

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _elapsedTime = '00:00:00.000';
  List<String> _laps = [];
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _startStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
        _isRunning = false;
      } else {
        _stopwatch.start();
        _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
          if (!mounted) {
            timer.cancel();
            return;
          }
          setState(() {
            _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
          });
        });
        _isRunning = true;
      }
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _stopwatch.reset();
      _stopwatch.stop(); // Ensure it's stopped
      _elapsedTime = '00:00:00.000';
      _laps.clear();
      _isRunning = false;
    });
  }

  void _lap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.add(_formatTime(_stopwatch.elapsedMilliseconds));
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;
    int hours = (milliseconds / (1000 * 60 * 60)).truncate();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr =
        hundreds.toString().padLeft(2, '0'); // Use 2 digits for hundredths

    return "$hoursStr:$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons stretch
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            _elapsedTime,
            style: const TextStyle(fontSize: 50.0, fontFamily: 'monospace'),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: _reset,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50), // Ensure minimum size
                backgroundColor: Colors.grey,
              ),
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: _lap,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50), // Ensure minimum size
                backgroundColor: _isRunning
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey[400],
              ),
              child: const Text('Lap'),
            ),
            ElevatedButton(
              onPressed: _startStop,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50), // Ensure minimum size
                backgroundColor: _isRunning ? Colors.redAccent : Colors.green,
              ),
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _laps.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lap ${index + 1}:'),
                    Text(_laps[index],
                        style: const TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
