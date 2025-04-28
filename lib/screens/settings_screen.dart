import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer for specific rebuilds or Provider.of for simplicity here
    final settings = Provider.of<SettingsProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        // --- Theme Setting ---
        ListTile(
          title: const Text('Theme'),
          trailing: DropdownButton<ThemeMode>(
            value: settings.themeMode,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Default'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark'),
              ),
            ],
            onChanged: (value) {
              settings.updateThemeMode(value);
            },
          ),
        ),
        const Divider(),

        // --- Time Format Setting ---
        ListTile(
          title: const Text('Time Format'),
          trailing: DropdownButton<TimeFormatOption>(
            value: settings.timeFormat,
            items: const [
              DropdownMenuItem(
                value: TimeFormatOption.hour12,
                child: Text('12-Hour (AM/PM)'),
              ),
              DropdownMenuItem(
                value: TimeFormatOption.hour24,
                child: Text('24-Hour'),
              ),
            ],
            onChanged: (value) {
              settings.updateTimeFormat(value);
            },
          ),
        ),
        const Divider(),

        // --- Placeholder for other settings ---
        ListTile(
          leading: const Icon(Icons.vibration),
          title: const Text('Haptic Feedback'),
          trailing: Switch(
            value: false, // TODO: Implement setting
            onChanged: (value) {
              // TODO: Update haptic setting
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Haptic Feedback TBD')));
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.notifications_active),
          title: const Text('Alarm Sound'),
          subtitle: const Text('Default'), // TODO: Implement setting
          onTap: () {
            // TODO: Show sound picker
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alarm Sound Picker TBD')));
          },
        ),
        ListTile(
          leading: const Icon(Icons.screen_lock_portrait),
          title: const Text('Keep Screen Awake'),
          trailing: Switch(
            value: false, // TODO: Implement setting (use wakelock package)
            onChanged: (value) {
              // TODO: Update wakelock setting
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Keep Screen Awake TBD')));
            },
          ),
        ),

        // Add more settings placeholders as needed...
      ],
    );
  }
}
