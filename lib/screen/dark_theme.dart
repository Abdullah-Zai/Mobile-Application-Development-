import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mid_project/provider/theme_changer_provider.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Appearance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _themeOption(
              context,
              icon: Icons.light_mode,
              title: 'Light Mode',
              subtitle: 'Bright and clean look',
              value: ThemeMode.light,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme,
            ),

            _themeOption(
              context,
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              subtitle: 'Easy on the eyes at night',
              value: ThemeMode.dark,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme,
            ),

            _themeOption(
              context,
              icon: Icons.settings_suggest,
              title: 'System Default',
              subtitle: 'Follow system settings',
              value: ThemeMode.system,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required ThemeMode value,
        required ThemeMode groupValue,
        required Function(ThemeMode) onChanged,
      }) {
    final isSelected = value == groupValue;

    return Card(
      elevation: isSelected ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: RadioListTile<ThemeMode>(
        value: value,
        groupValue: groupValue,
        onChanged: (val) => onChanged(val!),
        activeColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
